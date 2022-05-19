Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5852D615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbiESOa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbiESOa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 10:30:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4707ECC17A;
        Thu, 19 May 2022 07:30:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0293621BA7;
        Thu, 19 May 2022 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652970624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksHZxdVRk14EnrcHsj+kk3njdbVyXCR3+VlQoHpUCbA=;
        b=y0uKW6stVDJGXAUWRLLTQaHVZr6pwZBBIUmg0uvLEADMiG8nZnrxMTwpccUSWB35ezyPy9
        VcRk18SF1XxmFLZITJugUxGJvtR/ov3PysBUs6AxGCbgVp7n+oW5vxRbyOpySC9mbJRdH0
        WihUJ/SmAYhOZ7yCeMYjcgUjBVWdHsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652970624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksHZxdVRk14EnrcHsj+kk3njdbVyXCR3+VlQoHpUCbA=;
        b=RNFuWmBGUfcbg581uVEUBadzTF95IMlTqovFpmc79oejE4UHpwd3G6X4U8CCw0xfptOexH
        tJsj8dbjZrNwBUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76A9C13456;
        Thu, 19 May 2022 14:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ipb8GX9UhmLBRwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 19 May 2022 14:30:23 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id bbdc8505;
        Thu, 19 May 2022 14:31:01 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     He Zhe <zhe.he@windriver.com>, Dave Chinner <dchinner@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
        <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
Date:   Thu, 19 May 2022 15:31:00 +0100
In-Reply-To: <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
        (Amir Goldstein's message of "Thu, 19 May 2022 16:53:15 +0300")
Message-ID: <87czg94msb.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, May 19, 2022 at 11:22 AM He Zhe <zhe.he@windriver.com> wrote:
>>
>> Hi,
>>
>> We are experiencing the following warning from
>> "WARN_ON_ONCE(ret =3D=3D -EOPNOTSUPP);" in vfs_copy_file_range, from
>> 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
>>
>> # cat /sys/class/net/can0/phys_switch_id
>>
>> WARNING: CPU: 7 PID: 673 at fs/read_write.c:1516 vfs_copy_file_range+0x3=
80/0x440
>> Modules linked in: llce_can llce_logger llce_mailbox llce_core sch_fq_co=
del
>> openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defra=
g_ipv4
>> CPU: 7 PID: 673 Comm: cat Not tainted 5.15.38-yocto-standard #1
>> Hardware name: Freescale S32G399A (DT)
>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>> pc : vfs_copy_file_range+0x380/0x440
>> lr : vfs_copy_file_range+0x16c/0x440
>> sp : ffffffc00e0f3ce0
>> x29: ffffffc00e0f3ce0 x28: ffffff88157b5a40 x27: 0000000000000000
>> x26: ffffff8816ac3230 x25: ffffff881c060008 x24: 0000000000001000
>> x23: 0000000000000000 x22: 0000000000000000 x21: ffffff881cc99540
>> x20: ffffff881cc9a340 x19: ffffffffffffffa1 x18: ffffffffffffffff
>> x17: 0000000000000001 x16: 0000adfbb5178cde x15: ffffffc08e0f3647
>> x14: 0000000000000000 x13: 34613178302f3061 x12: 3178302b636e7973
>> x11: 0000000000058395 x10: 00000000fd1c5755 x9 : ffffffc008361950
>> x8 : ffffffc00a7d4d58 x7 : 0000000000000000 x6 : 0000000000000001
>> x5 : ffffffc009e81000 x4 : ffffffc009e817f8 x3 : 0000000000000000
>> x2 : 0000000000000000 x1 : ffffff88157b5a40 x0 : ffffffffffffffa1
>> Call trace:
>>  vfs_copy_file_range+0x380/0x440
>>  __do_sys_copy_file_range+0x178/0x3a4
>>  __arm64_sys_copy_file_range+0x34/0x4c
>>  invoke_syscall+0x5c/0x130
>>  el0_svc_common.constprop.0+0x68/0x124
>>  do_el0_svc+0x50/0xbc
>>  el0_svc+0x54/0x130
>>  el0t_64_sync_handler+0xa4/0x130
>>  el0t_64_sync+0x1a0/0x1a4
>> cat: /sys/class/net/can0/phys_switch_id: Operation not supported
>>
>> And we found this is triggered by the following stack. Specifically, all
>> netdev_ops in CAN drivers we can find now do not have ndo_get_port_paren=
t_id and
>> ndo_get_devlink_port, which makes phys_switch_id_show return -EOPNOTSUPP=
 all the
>> way back to vfs_copy_file_range.
>>
>> phys_switch_id_show+0xf4/0x11c
>> dev_attr_show+0x2c/0x6c
>> sysfs_kf_seq_show+0xb8/0x150
>> kernfs_seq_show+0x38/0x44
>> seq_read_iter+0x1c4/0x4c0
>> kernfs_fop_read_iter+0x44/0x50
>> generic_file_splice_read+0xdc/0x190
>> do_splice_to+0xa0/0xfc
>> splice_direct_to_actor+0xc4/0x250
>> do_splice_direct+0x94/0xe0
>> vfs_copy_file_range+0x16c/0x440
>> __do_sys_copy_file_range+0x178/0x3a4
>> __arm64_sys_copy_file_range+0x34/0x4c
>> invoke_syscall+0x5c/0x130
>> el0_svc_common.constprop.0+0x68/0x124
>> do_el0_svc+0x50/0xbc
>> el0_svc+0x54/0x130
>> el0t_64_sync_handler+0xa4/0x130
>> el0t_64_sync+0x1a0/0x1a4
>>
>> According to the original commit log, this warning is for operational va=
lidity
>> checks to generic_copy_file_range(). The reading will eventually return =
as
>> not supported as printed above. But is this warning still necessary? If =
so we
>> might want to remove it to have a cleaner dmesg.
>>
>
> Sigh! Those filesystems have no business doing copy_file_range()
>
> Here is a patch that Luis has been trying to push last year
> to fix a problem with copy_file_range() from tracefs:
>
> https://lore.kernel.org/linux-fsdevel/20210702090012.28458-1-lhenriques@s=
use.de/

Yikes!  It's been a while and I completely forgot about it.  I can
definitely try to respin this patch if someone's interested in picking
it.  I'll have to go re-read everything again and see what's missing and
what has changed in between.

Cheers,
--=20
Lu=C3=ADs

> Luis gave up on it, because no maintainer stepped up to take
> the patch, but I think that is the right way to go.
>
> Maybe this bug report can raise awareness to that old patch.
>
> Al, could you have a look?
>
> Thanks,
> Amir.
>
