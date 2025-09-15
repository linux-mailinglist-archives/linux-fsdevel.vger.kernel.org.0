Return-Path: <linux-fsdevel+bounces-61446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF78B58452
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 20:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30BB17972D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CDB2BDC1B;
	Mon, 15 Sep 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E62dh8OI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE91E7C10
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960154; cv=none; b=fJgaVivxfh3BbU7nfwO3VbvdETeVgs/8VFQxdB6v5YPkzZAtoJTBUKBS7F7bruwp5NWmVSL+OStkGtcgy8SBn8KJL4lR/MtO35O9E6j+mIYOi9cOwpGAtX6mkI04fG9XHkA33Sj7xtI1Y+cl73Wp+5CMn4wLaVakQmOQUAPFqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960154; c=relaxed/simple;
	bh=6UpnMZ/T1iZdTKap0yVD6xu+W5D/5epLwyfVQ+y16D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2rua+G44uUFJz7m5/FZkvqDiPljvDKtWlalDpp/mAkYWj10QS6nS1b+fB5ueREvzEhdC48vPSDW80lrxaR9M4+22yxd1eSp2scbUauh+e0sge8sxHqfNwUNSNSooGtp1hygsNhQNZDKciagR6MQTuWHReF4NIQB5RihkWPhhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E62dh8OI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5e35453acso56587291cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757960152; x=1758564952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbVqoe4RthpIRgsdKVteVgT/ga7ixMb4Ej36pOkiwRQ=;
        b=E62dh8OItVgBEc5dFpg4baSYW66/FXcGl5UlgXC76fCLcZzypVLQChtOk6cXc/IWdU
         zdBhRk8T6UJw2cGiYAgH8WKgi4J+W7+3HUbZKkj6/7tjFMUUNttRP9DivD4goLey4SQ+
         g/aenah4Rlul9TyyGSCzspp1Nz9mwBPuShgN4VMbl49Acgy93WX/tHmh485Varnc3vAB
         up0VaG6uwBbbB79Bk2jcP/ia3km40cRY94BRk/oN3fwgMstao+PvprTZLS9NyR4ZWOtG
         sX0BJuGkrz4Tmm9ZxSQp6RANNSiNCGWAOSFGBVJl9MWgP4iI7hy4aZlPVJl8OzR2XHe6
         +7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960152; x=1758564952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbVqoe4RthpIRgsdKVteVgT/ga7ixMb4Ej36pOkiwRQ=;
        b=cQIjOvGNPcqJOMzbxhHDmohVm46E93JJ62lO2oK7PolOINuZZZDEBN4FAp90XutiL8
         hgjwpV2ghDuvoXbcn5Ei2Ap3ZmxFq0R0+iV4/n0vERMXfOtQErfq7dUS0JGhtu3e1Ahc
         Lxz3mqRD86ZEZJAkjq8qRRQAQohAd1o0SAtGxDMMvv4HUf/hJ3wxH+vay3GEr8OgyjYH
         pyABcA8qMvs+azxP4MXtaYNst+Q054bAzpQMCUd8eM4QKCy91UZDdSg0q5WMzAMHpAVT
         ow3VwPROuzIfC2ZhOQXdszblnjt+qsbxQnjhdAwukxVKZU27YFHZzobYl8u5mS1RD8Ai
         CtZQ==
X-Gm-Message-State: AOJu0Yyc6XAXqe/kZpT34QIWW4bUKG2SsfkvFncERKMkZ9TCuwMOjqxm
	me58oIehEr7VwyQSu+l5GjO7ym7Z2Vm+aJEZNvs/c9BEb39smaeCexIpK2+nhG4iHflmjWKfdK1
	KWcVZAd9YZIKZOPdKXXQVhAtS0CzIqRBvJSg6rRk=
X-Gm-Gg: ASbGncsKTnet2xzR2bP0Pa/PtdngYVn8daVMk7fZlOXKIHgj3mN6j73Sp13fOwpYxE0
	HFLe0XZ5y9aC5bAnStnxpJpt7jaIEkx9spT3bmWrLuHBbP1U4uCqB2CuubUCkO7MRjhDaCb/X8n
	flO6EOpbi06sXL8edkFrucUQTC+CBo9+iYIeNVt3rnmnVX9uGRtqazI+fhRPWjFwj5FDTUWIFDU
	UEY/xsN8R6SQUks+d+8pyDt606yw086Rg1X41l6
X-Google-Smtp-Source: AGHT+IFzrC+t8qw9/2Occ7suxEqAMvNrOw6hNwAD+tGDadbLt86aVs+IjwhBb7wI04fWKOoT4W77uFBSJO3gbd8Pahk=
X-Received: by 2002:a05:622a:1483:b0:4b5:d651:2e2f with SMTP id
 d75a77b69052e-4b77d035fdbmr198496301cf.39.1757960150691; Mon, 15 Sep 2025
 11:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
In-Reply-To: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Sep 2025 11:15:39 -0700
X-Gm-Features: Ac12FXwPiF1opMcgmBiXJSYh49N54oKCTaNTFf161bhatMuzqO3P0ctdsMX_1rc
Message-ID: <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from fuse_uring_cancel
To: Jian Huang Li <ali@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, bschubert@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:34=E2=80=AFAM Jian Huang Li <ali@ddn.com> wrote:
>
> This issue could be observed sometimes during libfuse xfstests, from
> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
>
> The cause is, if when fuse daemon just submitted
> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
> this very early stage. After all uring queues stopped, might have one or
> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then some
> new ring entities are created and added to ent_avail_queue, and
> immediately fuse_uring_cancel moves them to ent_in_userspace after SQEs
> get canceled. These ring entities will not be moved to ent_released, and
> will stay in ent_in_userspace when fuse_uring_destruct is called, needed
> be freed by the function.

Hi Jian,

Does it suffice to fix this race by tearing down the entries from the
available queue first before tearing down the entries in the userspace
queue? eg something like

 static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
 {
-       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
-                                    FRRS_USERSPACE);
        fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
                                     FRRS_AVAILABLE);
+       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
+                                    FRRS_USERSPACE);
 }

AFAICT, the race happens right now because when fuse_uring_cancel()
moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
ent_in_userspace queue, fuse_uring_teardown_entries() may have already
called fuse_uring_stop_list_entries() on the ent_in_userspace queue,
thereby now missing the just-moved entries altogether, eg this logical
flow

-> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
    -> fuse_uring_cancel() moves entry from avail q to userspace q
-> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);

If instead fuse_uring_teardown_entries() stops the available queue first, t=
hen
-> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
    -> fuse_uring_cancel()
-> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);

seems fine now and fuse_uring_cancel() would basically be a no-op
since ent->state is now FRRS_TEARDOWN.


Thanks,
Joanne



>
> Fixes: b6236c8407cb ("fuse: {io-uring} Prevent mount point hang on
> fuse-server termination")
> Signed-off-by: Jian Huang Li <ali@ddn.com>
> ---
>   fs/fuse/dev_uring.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 249b210becb1..eed0fc6c8b05 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -201,7 +201,20 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>                 WARN_ON(!list_empty(&queue->ent_avail_queue));
>                 WARN_ON(!list_empty(&queue->ent_w_req_queue));
>                 WARN_ON(!list_empty(&queue->ent_commit_queue));
> -               WARN_ON(!list_empty(&queue->ent_in_userspace));
> +
> +               /*
> +                * ent_in_userspace might not be empty, because
> +                * FUSE_IO_URING_CMD_REGISTER is not accounted yet
> +                * in ring->queue_refs and fuse_uring_wait_stopped_queues=
()
> +                * then passes too early. fuse_uring_cancel() adds these
> +                * commands to queue->ent_in_userspace - they need
> +                * to be freed here
> +                */
> +               list_for_each_entry_safe(ent, next, &queue->ent_in_usersp=
ace,
> +                                        list) {
> +                       list_del_init(&ent->list);
> +                       kfree(ent);
> +               }
>
>                 list_for_each_entry_safe(ent, next, &queue->ent_released,
>                                          list) {
> --
> 2.47.1
>

