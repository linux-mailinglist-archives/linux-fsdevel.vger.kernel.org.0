Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5897574E71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbiGNM43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiGNM42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5E6501AD;
        Thu, 14 Jul 2022 05:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53FFD61ABD;
        Thu, 14 Jul 2022 12:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06215C34114;
        Thu, 14 Jul 2022 12:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657803386;
        bh=hrsu0e9uFa34VFtASKInMBXdiKJre5nSTINGcuYMOCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDzKmLvVAYS/h/bodFdEF3t5bFtPyikzMRC7yLbnv+S1xUHFg2UdNLyNf6sTTnQcN
         T0WlhUXkINhzQop08udp0UOE5WlxVT5pWuhnenpttiFuffVINEYyJj94SqfTTki/cR
         iqBcbvUm8jw23zXllhGv3Tzlg/8k7f49S7RjzqqZ6u+CB+cOcJu4kDx25ox+oEP1v4
         ATPEWXXbknbeW8fuyxaz2XIsDdNu6KOIOh7yUsMz72ExT33oPv8HtBsQnI8PDciQnq
         gXW7q7hjZY1L9RrX5mmmALdWkUWXD4rHl1xaKmdQNkekwWPanwXRX91WRoakiaDH2I
         nOEiK09g9r3KQ==
Date:   Thu, 14 Jul 2022 14:56:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org, pvorel@suse.cz
Subject: Re: [PATCH v10 1/4] fs: add mode_strip_sgid() helper
Message-ID: <20220714125620.iwww4eivtbytzlgg@wittgenstein>
References: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:11:25PM +0800, Yang Xu wrote:
> Add a dedicated helper to handle the setgid bit when creating a new file
> in a setgid directory. This is a preparatory patch for moving setgid
> stripping into the vfs. The patch contains no functional changes.
> 
> Currently the setgid stripping logic is open-coded directly in
> inode_init_owner() and the individual filesystems are responsible for
> handling setgid inheritance. Since this has proven to be brittle as
> evidenced by old issues we uncovered over the last months (see [1] to
> [3] below) we will try to move this logic into the vfs.
> 
> Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [1]
> Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
> Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Fyi, I'm on vacation this week and will review this when I get back and
if things look sane plan to pick it up for the next mw.

Christian
