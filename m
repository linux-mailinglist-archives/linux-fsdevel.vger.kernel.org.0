Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE235A6430
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiH3M5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiH3M5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:57:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEBF14021
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:56:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h78so9089548iof.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=s8CAzcFQQ1JEIFm/xIDxgpF38X0rphe9eJgoXZx6o6o=;
        b=R7pTSVdhKh3Yg5UyVfqrSE7yhVVUZ/E2bvZaHwStxxJ+EXYPgleEK3FCRby0hqR2FG
         Fo8Du7D+1i1RzUUOYmkJqnmryUtxZnd0f3vKBGcaa2sFCq3/prJUdygZkwnv4H8rQt5m
         26AZVXHIzhZ65ozNTvYutkYcjVMec0iQIZVB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=s8CAzcFQQ1JEIFm/xIDxgpF38X0rphe9eJgoXZx6o6o=;
        b=gsrSkvxa5tUmh/psci20C4GMcmfMTgGWuZvdtunhKJWDK5fANab2vWFCc66pGc2FPm
         VaRSSygRRsNeAEF4xJwfGVchYFAlbmupSqEilZO7NWo/2f2Rb1POTombSbsGAyqqKG5Y
         PJTymrkr5W8lYmLlDwk3FaKn7GnF+jjeqvmitW7DkB9RlJyiPN58fF0PKcos32P+1d72
         IXCwstdjNtA6Bvtr2dly6qn7jb2mi3y2lMSArLrtudqbDzWlydQa50F6YSOcIwFZ4VGJ
         RltuSqAbhpkZxWB0DaZdrsnGOF8j1moycGH/NITGCLqm/vQAS/8uAolAxw1+jZkoWxpZ
         EwhA==
X-Gm-Message-State: ACgBeo260TBzCQrCGcMEpFmBZB8vOSkMYH07gnjxSGSorMQrlhV16HBk
        ExAiyhig3ZMDwpU3Al9c3FonZkgfmVh1cw==
X-Google-Smtp-Source: AA6agR7lZj1GSYX+fd7+5twcABeUVT1OPSFqkCTqkAYEn3ZK7oXYC79smOs+3LrM1pZEhCgj9UHhEg==
X-Received: by 2002:a02:7a5d:0:b0:349:bb96:3001 with SMTP id z29-20020a027a5d000000b00349bb963001mr12855057jad.35.1661864172650;
        Tue, 30 Aug 2022 05:56:12 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:56b6:7d8a:b26e:6073])
        by smtp.gmail.com with ESMTPSA id y9-20020a056638228900b00344c3de5ec7sm5411836jas.150.2022.08.30.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:56:12 -0700 (PDT)
Date:   Tue, 30 Aug 2022 07:56:11 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] acl: move idmapping handling into
 posix_acl_xattr_set()
Message-ID: <Yw4I6800XBquSWf5@do-x1extreme>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-5-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-5-brauner@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:43PM +0200, Christian Brauner wrote:
> The uapi POSIX ACL struct passed through the value argument during
> setxattr() contains {g,u}id values encoded via ACL_{GROUP,USER} entries
> that should actually be stored in the form of k{g,u}id_t (See [1] for a
> long explanation of the issue.).
> 
> In 0c5fd887d2bb ("acl: move idmapped mount fixup into vfs_{g,s}etxattr()")
> we took the mount's idmapping into account in order to let overlayfs
> handle POSIX ACLs on idmapped layers correctly. The fixup is currently
> performed directly in vfs_setxattr() which piles on top of the earlier
> hackiness by handling the mount's idmapping and stuff the vfs{g,u}id_t
> values into the uapi struct as well. While that is all correct and works
> fine it's just ugly.
> 
> Now that we have introduced vfs_make_posix_acl() earlier move handling
> idmapped mounts out of vfs_setxattr() and into the POSIX ACL handler
> where it belongs.
> 
> Note that we also need to call vfs_make_posix_acl() for EVM which
> interpretes POSIX ACLs during security_inode_setxattr(). Leave them a
> longer comment for future reference.
> 
> All filesystems that support idmapped mounts via FS_ALLOW_IDMAP use the
> standard POSIX ACL xattr handlers and are covered by this change. This
> includes overlayfs which simply calls vfs_{g,s}etxattr().
> 
> The following filesystems use custom POSIX ACL xattr handlers: 9p, cifs,
> ecryptfs, and ntfs3 (and overlayfs but we've covered that in the paragraph
> above) and none of them support idmapped mounts yet.
> 
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org/ [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
