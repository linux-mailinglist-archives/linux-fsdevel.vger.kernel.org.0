Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062AF66E3E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjAQQny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 11:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjAQQnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A022A4347E
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 08:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673973761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1XYXuuLEP6Cp3MDBQnimJhyZi1pptC2mWI6feDk5oo=;
        b=PDMuLzQ39+9EIMa6XZO7IAUM8ZW8yEOhq5/lpHQKNT4F2Lvl7/edbwI8b7zOwhHn1EGcim
        VVk1r3TvXA2P53yXX97UWQYDMDtrn4uqIWhgWECEpkpUIYROkxWL0qG7jxuTGsoEYldsEz
        BesM+9276RXdnnt/carNEUjVcoNTDZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-NQbUAJSXOkeF4aLyKdnAug-1; Tue, 17 Jan 2023 11:42:38 -0500
X-MC-Unique: NQbUAJSXOkeF4aLyKdnAug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87C13101BE23;
        Tue, 17 Jan 2023 16:42:37 +0000 (UTC)
Received: from ws.net.home (ovpn-194-37.brq.redhat.com [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6505F40C6EC4;
        Tue, 17 Jan 2023 16:42:36 +0000 (UTC)
Date:   Tue, 17 Jan 2023 17:42:34 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: btrfs mount failure with context option and latest mount command
Message-ID: <20230117164234.znsa4oeoovcdpntu@ws.net.home>
References: <20230116101556.neld5ddm6brssy4n@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116101556.neld5ddm6brssy4n@shindev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:15:58AM +0000, Shinichiro Kawasaki wrote:
> I observe mount command with -o context option fails for btrfs, using mount
> command built from the latest util-linux master branch code (git hash
> dbf77f7a1).
> 
> $ sudo mount -o context="system_u:object_r:root_t:s0" /dev/nullb1 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/nullb1, missing codepage or helper program, or other error.
>        dmesg(1) may have more information after failed mount system call.
> 
> Kernel reports an SELinux error message:
> 
> [565959.593054][T12131] SELinux: mount invalid.  Same superblock, different security settings for (dev nullb1, type btrfs)
> 
> Is this a known issue?

Not for me.

> Details:
> 
> - Mount succeeds without the -o context option.
> - Ext4 succeeds to mount with the option.
> - Mount succeeds rolling back util-linux code to older git hash 8241fb005,
>   which was committed on January 3rd. After this commit, a number of commits
>   were merged to util-linux to use fsconfig syscall for mount in place of
>   mount syscall.
> 
> Then the new fsconfig syscall looks the trigger of the failure. I took a look in
> the code of mount path and saw that btrfs is not modified to use struct
> fs_context for the fsconfig syscall. The -o context option is parsed and kept in
> security field of fs_context, but it is not passed to btrfs_mount.

It's a serious issue if btrfs is not ready for the new kernel fsconfig
interface. I guess libmount cannot do anything else in this case
(well, we can switch back to classic mount(2), but it sounds as a
wrong solution).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

