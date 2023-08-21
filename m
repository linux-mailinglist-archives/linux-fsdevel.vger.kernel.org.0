Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8796782BA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 16:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjHUOYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjHUOYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:24:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16448E2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 07:24:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1c66876aso447477666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692627852; x=1693232652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NipE8Lxin/pCkzOpkao8SnUSJGudRzD0GF/Rtrjn1zc=;
        b=WF4GksaOPtUGKCC4gC83q7rI8e1L2TyQoqaveQgi1MWFOVEHgEqOJL2VCOllsQHs4Z
         Bbfh0LoPXiWZVR89UfwzEOpLbJwGHWkOTSNdil58LKRBO0KMjlAQA72FNOzR7WLgyI9S
         vsNCWNB3Gy8KfTcujwEyhoVhHW+TZLyqUPpy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627852; x=1693232652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NipE8Lxin/pCkzOpkao8SnUSJGudRzD0GF/Rtrjn1zc=;
        b=C3XLat+kYjr+Cx/QBCeaAJj7xxVt+P0PLM6OofK94/6QUo6rkVYe89nL+yhRi25fDO
         Q+a8e8rK9vBXz4iSu7Ty7CBIRLigCm+wm1CgB1sYBJfaA2BwcDHAkKfkOBlBPDp6SepF
         r+wu8plQ9I8Css0UMipmh+QBgGyYIYSLtPOOXgI++VdmmEEoUuttjonjMyrvuGx+8sln
         TXlR0SJJHUCBQwD/ZcaPt2U5gmoty090EzegE4iQZGjg+3e+6UPIuxG53jVh1UvVMI31
         xJ+NCzTm2a7zvUnWVRutTgkMktPqRSWCr62dCMnBNMvPFpnSkz3wFa2NdoAPeMyiQUsK
         YBYw==
X-Gm-Message-State: AOJu0YwY4esBFMQXzk1tzhKPLmj+kDkputZHJ8NyBL3kqhtb40dDuWhx
        Qr4a+dwZdlJykAeGPwGn7ILuoX/ROkdJvysQnDGOsQ==
X-Google-Smtp-Source: AGHT+IEvHdrhoUhs2RBdQ0lNh05gQtxqXKHu45j4UDm/xk5pf4kcGUz69Z1SLEnzMa4fX0sUSCO6eAC+eOavC9lJmmE=
X-Received: by 2002:a17:907:a04b:b0:99b:507d:dc05 with SMTP id
 gz11-20020a170907a04b00b0099b507ddc05mr5557766ejc.16.1692627852176; Mon, 21
 Aug 2023 07:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
 <ZNozdrtKgTeTaMpX@tycho.pizza> <CAJfpegt6x_=F=mD8LEL4AZPbfCLGQrpurhtbDN4Ew50fd2ngqQ@mail.gmail.com>
 <ZNqseD4hqHWmeF2w@tycho.pizza>
In-Reply-To: <ZNqseD4hqHWmeF2w@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Aug 2023 16:24:00 +0200
Message-ID: <CAJfpegtzj7=f99=m49DShDTgLpGAzx8gpHSakgPn0qe+dNjHdw@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async fuse_flush
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Aug 2023 at 00:36, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Mon, Aug 14, 2023 at 04:35:56PM +0200, Miklos Szeredi wrote:
> > On Mon, 14 Aug 2023 at 16:00, Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > > It seems like we really do need to wait here. I guess that means we
> > > need some kind of exit-proof wait?
> >
> > Could you please recap the original problem?
>
> Sure, the symptom is a deadlock, something like:
>
> # cat /proc/1528591/stack
> [<0>] do_wait+0x156/0x2f0
> [<0>] kernel_wait4+0x8d/0x140
> [<0>] zap_pid_ns_processes+0x104/0x180
> [<0>] do_exit+0xa41/0xb80
> [<0>] do_group_exit+0x3a/0xa0
> [<0>] __x64_sys_exit_group+0x14/0x20
> [<0>] do_syscall_64+0x37/0xb0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> which is stuck waiting for:
>
> # cat /proc/1544574/stack
> [<0>] request_wait_answer+0x12f/0x210
> [<0>] fuse_simple_request+0x109/0x2c0
> [<0>] fuse_flush+0x16f/0x1b0
> [<0>] filp_close+0x27/0x70
> [<0>] put_files_struct+0x6b/0xc0
> [<0>] do_exit+0x360/0xb80
> [<0>] do_group_exit+0x3a/0xa0
> [<0>] get_signal+0x140/0x870
> [<0>] arch_do_signal_or_restart+0xae/0x7c0
> [<0>] exit_to_user_mode_prepare+0x10f/0x1c0
> [<0>] syscall_exit_to_user_mode+0x26/0x40
> [<0>] do_syscall_64+0x46/0xb0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> I have a reproducer here:
> https://github.com/tych0/kernel-utils/blob/master/fuse2/Makefile#L7

The issue seems to be that the server process is recursing into the
filesystem it is serving (nested_fsync()).  It's quite easy to
deadlock fuse this way, and I'm not sure why this would be needed for
any server implementation.   Can you explain?

Thanks,
Miklos
