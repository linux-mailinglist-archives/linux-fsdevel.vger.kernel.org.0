Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B7A6E5D01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 11:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDRJIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDRJIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE7659E;
        Tue, 18 Apr 2023 02:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4688D61B1C;
        Tue, 18 Apr 2023 09:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47F1C433D2;
        Tue, 18 Apr 2023 09:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681808893;
        bh=/TGjxtJugjADcv+bp2Z47PlcioFCR2cdHAZw6bKOkHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pp5nPlueSoTeeAkF+K54c2C71mg4SuGRp5hkgDI0ts9sKD/4YdDMXgo521KcX9RHX
         HHXU9+octQcYtL0yUmgW4UsS3QJcUSTRZ/2u3I7W+pjr8fxmwSgUGnrghdAMmmCp/a
         DnDUYssFoFkUdl0TKr23OjIomHYgn8EkuHet7Anz+L83jL0ifeLEoBc1uLLJMl2pMu
         LjWPqee8shUkAN2tTKFFNa1G27xl/ukGbLM1opAgFnAg5115ppgTScaRpgdqPzjxik
         oVJxPIs5moNHNltdozr9hjNniBDyyuaFv2orV0mZnIejZtsxKrGqfxvg017v/Mik9x
         FlBBaWiQOY8wQ==
Date:   Tue, 18 Apr 2023 11:08:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IMA: use vfs_getattr_nosec to get the i_version
Message-ID: <20230418-engste-gastwirtschaft-601fb389bba5@brauner>
References: <20230417165551.31130-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230417165551.31130-1-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 12:55:51PM -0400, Jeff Layton wrote:
> IMA currently accesses the i_version out of the inode directly when it
> does a measurement. This is fine for most simple filesystems, but can be
> problematic with more complex setups (e.g. overlayfs).
> 
> Make IMA instead call vfs_getattr_nosec to get this info. This allows
> the filesystem to determine whether and how to report the i_version, and
> should allow IMA to work properly with a broader class of filesystems in
> the future.
> 
> Reported-and-Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Excellent, thanks,
Reviewed-by: Christian Brauner <brauner@kernel.org>
