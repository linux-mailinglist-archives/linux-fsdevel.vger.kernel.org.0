Return-Path: <linux-fsdevel+bounces-50484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C96ACC874
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5273418954DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A5A23A563;
	Tue,  3 Jun 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="XFGPiWWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240F239E73
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958696; cv=none; b=WadyVj04MajLTPzyAtOdl5n3yFRM4BxMwXprOSnT1AtoiPWfs77QxbKRE6/qkfrh0pAROhCsU8+4wUT/fsltJX/HFGjXVKzqpZQSKVA01UU7ZqNXhgRGYg7VrOvF3df1mluz99sOxngeGyhJmSpmBKqpCn1EmL/AcHD8vpz2S00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958696; c=relaxed/simple;
	bh=+F34Vzv+gCtJCcusCLhnNO8q/5nDX3qbC7ir8iSecR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huSr16b+bX8McMxi+NEMl3OTgnTYcicixEI3ClRlZ88RMGdmm6Q9B/huIYcATdotCiJnfFKsXxkjVd5MBqBcJjcbYi3blJDjKkhK45TrGGxLZ3kdMv673IgBAj3YSywe7i98PIT3nHM6lcmp6ZTxEpZsLLk548xarwhKJWWODgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=XFGPiWWG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54998f865b8so5361103e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1748958692; x=1749563492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BQtT9+ML5ohPE+2zJdckvA1msj94Y3SqV9STQ8HAE0=;
        b=XFGPiWWGPn3vk8Baj1e+QHv0vmPTBpRTSnssFVn1ddBOl9CzUSZoFRCTjNYCKWi3ER
         /lfVfuutkV5abifuLsBjvKsZ5EpQebcjqbEF4GXKR+pkvK05e3oyZnZyFv26/akZM7OC
         sc5XmI/5gj2a94pf2TsPmjmyPkcRkWbXST0ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958692; x=1749563492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BQtT9+ML5ohPE+2zJdckvA1msj94Y3SqV9STQ8HAE0=;
        b=Cws4cs+HFOso75BbojbGTglAv4zORW89Fe1gkpLJFo9V/CRGAkC/FA9Kpi2Ou2XWVC
         jO5ZvRNhWSqkqoCZ6zN/ECDkmHgmBRGs/gJ++fybxgT8nQKUX8gE8XjG+Fj8jhhS1Xcw
         1YWZ2V7EDBSEu8wCaebEkhKEgXnUYhzESWSIykVhG71V3Nhl5oPS/XMDSXJGAAKMKpb9
         M10OrqsEMCiyVwEzVQ/L1yQgwV6ezkngm4a/Pm7NwoI21wF0XAuX2HDLsHqrybR9tLwL
         oVYz1YNZvZmCMAtik3jntyKUBPMPnTFB4PGgSPohsbSKNllbSf6GViDCc2Y+T2HT7QMM
         XuhA==
X-Gm-Message-State: AOJu0YyjoOb1ICfpqeSAATLOSQcn22w0H+wZXDZPbS6Xd0KApJ8cFVbM
	E8b09lnTE67p/yH+Iz4TxNqmF+xyzWAvA9coA5FaelmSB0bnNbF83hHoqdE2WmSfAjdb0VlMTzZ
	Tl/cYBftKrm//kz3LZMthBqCgENn9noz6UC+xseXxCA==
X-Gm-Gg: ASbGncs1aGACpKWK9l10rHt1YTYq/UwIcrO7NvI2o9r9ZIHUFWQhQkxiNqUvCDKTqHZ
	0ZvpYUXn0mopy4uSkdOryt1MdIOIqeIn0dzcRYlL9rfPYdI/tH3HYrTQEks+ZHMrFD+mXQoX6m3
	JpfW6DkNcpTUsI+i2gaWt5OLZqPDRs6zqkVG9a88d8axer
X-Google-Smtp-Source: AGHT+IF3hNwWe5J1kqbHRFg2ro6ZDJgxF0iFP6rWNJt8Cep6Mu/2Lywo5i7PbzoHKTZNAJRuabrVH7aP9fdUs6gntbI=
X-Received: by 2002:a05:6512:3191:b0:553:2ed1:ab1e with SMTP id
 2adb3069b0e04-5533b937c18mr5174736e87.46.1748958691927; Tue, 03 Jun 2025
 06:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
 <20250603-work-coredump-socket-protocol-v2-4-05a5f0c18ecc@kernel.org>
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-4-05a5f0c18ecc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Jun 2025 15:51:20 +0200
X-Gm-Features: AX0GCFtAoUYmT5bceY05tSspVRqNRbh6X9b6gJRWQ6JS5dG6O43sDPtJR5f1ZZs
Message-ID: <CAJqdLrpR_eJpxJKqBw1C+uE_VZgO=KFOtqX+hUH2s_HPJi2JDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tools: add coredump.h header
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 3. Juni 2025 um 15:32 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Copy the coredump header so we can rely on it in the selftests.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/include/uapi/linux/coredump.h | 104 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
> new file mode 100644
> index 000000000000..4fa7d1f9d062
> --- /dev/null
> +++ b/tools/include/uapi/linux/coredump.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_LINUX_COREDUMP_H
> +#define _UAPI_LINUX_COREDUMP_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * coredump_{req,ack} flags
> + * @COREDUMP_KERNEL: kernel writes coredump
> + * @COREDUMP_USERSPACE: userspace writes coredump
> + * @COREDUMP_REJECT: don't generate coredump
> + * @COREDUMP_WAIT: wait for coredump server
> + */
> +enum {
> +       COREDUMP_KERNEL         = (1ULL << 0),
> +       COREDUMP_USERSPACE      = (1ULL << 1),
> +       COREDUMP_REJECT         = (1ULL << 2),
> +       COREDUMP_WAIT           = (1ULL << 3),
> +};
> +
> +/**
> + * struct coredump_req - message kernel sends to userspace
> + * @size: size of struct coredump_req
> + * @size_ack: known size of struct coredump_ack on this kernel
> + * @mask: supported features
> + *
> + * When a coredump happens the kernel will connect to the coredump
> + * socket and send a coredump request to the coredump server. The @size
> + * member is set to the size of struct coredump_req and provides a hint
> + * to userspace how much data can be read. Userspace may use MSG_PEEK to
> + * peek the size of struct coredump_req and then choose to consume it in
> + * one go. Userspace may also simply read a COREDUMP_ACK_SIZE_VER0
> + * request. If the size the kernel sends is larger userspace simply
> + * discards any remaining data.
> + *
> + * The coredump_req->mask member is set to the currently know features.
> + * Userspace may only set coredump_ack->mask to the bits raised by the
> + * kernel in coredump_req->mask.
> + *
> + * The coredump_req->size_ack member is set by the kernel to the size of
> + * struct coredump_ack the kernel knows. Userspace may only send up to
> + * coredump_req->size_ack bytes to the kernel and must set
> + * coredump_ack->size accordingly.
> + */
> +struct coredump_req {
> +       __u32 size;
> +       __u32 size_ack;
> +       __u64 mask;
> +};
> +
> +enum {
> +       COREDUMP_REQ_SIZE_VER0 = 16U, /* size of first published struct */
> +};
> +
> +/**
> + * struct coredump_ack - message userspace sends to kernel
> + * @size: size of the struct
> + * @spare: unused
> + * @mask: features kernel is supposed to use
> + *
> + * The @size member must be set to the size of struct coredump_ack. It
> + * may never exceed what the kernel returned in coredump_req->size_ack
> + * but it may of course be smaller (>= COREDUMP_ACK_SIZE_VER0 and <=
> + * coredump_req->size_ack).
> + *
> + * The @mask member must be set to the features the coredump server
> + * wants the kernel to use. Only bits the kernel returned in
> + * coredump_req->mask may be set.
> + */
> +struct coredump_ack {
> +       __u32 size;
> +       __u32 spare;
> +       __u64 mask;
> +};
> +
> +enum {
> +       COREDUMP_ACK_SIZE_VER0 = 16U, /* size of first published struct */
> +};
> +
> +/**
> + * enum coredump_oob - Out-of-band markers for the coredump socket
> + *
> + * The kernel will place a single byte coredump_oob marker on the
> + * coredump socket. An interested coredump server can listen for POLLPRI
> + * and figure out why the provided coredump_ack was invalid.
> + *
> + * The out-of-band markers allow advanced userspace to infer more details
> + * about a coredump ack. They are optional and can be ignored. They
> + * aren't necessary for the coredump server to function correctly.
> + *
> + * @COREDUMP_OOB_INVALIDSIZE: the provided coredump_ack size was invalid
> + * @COREDUMP_OOB_UNSUPPORTED: the provided coredump_ack mask was invalid
> + * @COREDUMP_OOB_CONFLICTING: the provided coredump_ack mask has conflicting options
> + * @__COREDUMP_OOB_MAX: the maximum value for coredump_oob
> + */
> +enum coredump_oob {
> +       COREDUMP_OOB_INVALIDSIZE = 1U,
> +       COREDUMP_OOB_UNSUPPORTED = 2U,
> +       COREDUMP_OOB_CONFLICTING = 3U,
> +       __COREDUMP_OOB_MAX       = 255U,
> +} __attribute__ ((__packed__));
> +
> +#endif /* _UAPI_LINUX_COREDUMP_H */
>
> --
> 2.47.2
>

