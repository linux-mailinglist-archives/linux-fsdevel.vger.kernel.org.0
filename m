Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E28715906
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 10:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjE3Iuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 04:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjE3Iuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 04:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CE4BE;
        Tue, 30 May 2023 01:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D1361870;
        Tue, 30 May 2023 08:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51547C433D2;
        Tue, 30 May 2023 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685436646;
        bh=YNggnKnwtaASUyaCFQCb+6vH6GXHzQlXJx39u2e9+yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bp5Er4TA2QcOqQM4Pks2ChB9sv7gZpRdkNWWOhraRqR6rltwt1yipf0jByrnhjiAn
         vKUw/MsZ5+Ih71F1jdJUeGmoEf6rKzaj8yVSCJ1s7uqE5k22uvCnlOzPN2NhSzmxyc
         k7N7SQZm9g42BHB5fefjCe/dz8T4VIL3ukRrqJaKuFb1sPDLEn3PbjS87SSxBUwy14
         0STtnyWAKoIwWoZSeidcMaDYtnxW4bFR7KilvympvJ2GPiVIc5+d7ogQ+MyO2wSrFq
         qXssmt4DKIYOqx3RBifCrQtlWRdIpNLmqQAk7yKS3tuZ5RgH6GNlmkMH7PeVrm+Ka8
         5l25PlXDbrm9A==
Date:   Tue, 30 May 2023 10:50:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     chenzhiyin <zhiyin.chen@intel.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nanhai.zou@intel.com
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
Message-ID: <20230530-wortbruch-extra-88399a74392e@brauner>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530020626.186192-1-zhiyin.chen@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 29, 2023 at 10:06:26PM -0400, chenzhiyin wrote:
> In the syscall test of UnixBench, performance regression occurred
> due to false sharing.
> 
> The lock and atomic members, including file::f_lock, file::f_count
> and file::f_pos_lock are highly contended and frequently updated
> in the high-concurrency test scenarios. perf c2c indentified one
> affected read access, file::f_op.
> To prevent false sharing, the layout of file struct is changed as
> following
> (A) f_lock, f_count and f_pos_lock are put together to share the
> same cache line.
> (B) The read mostly members, including f_path, f_inode, f_op are
> put into a separate cache line.
> (C) f_mode is put together with f_count, since they are used
> frequently at the same time.
> 
> The optimization has been validated in the syscall test of
> UnixBench. performance gain is 30~50%, when the number of parallel
> jobs is 16.
> 
> Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
> ---

Sounds interesting, but can we see the actual numbers, please? 
So struct file is marked with __randomize_layout which seems to make
this whole reordering pointless or at least only useful if the
structure randomization Kconfig is turned off. Is there any precedence
to optimizing structures that are marked as randomizable?
