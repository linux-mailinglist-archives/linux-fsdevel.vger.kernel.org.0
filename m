Return-Path: <linux-fsdevel+bounces-40091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9CFA1BE47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABBA3A1F28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF91DDC2F;
	Fri, 24 Jan 2025 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw6ieSbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA91E7C27
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756328; cv=none; b=mQDszXZAr1D73qBxbVn5e6gQrx8f0f1gMLMVpPG6JlqX6M1xl8SwIugVYK5H7xWXfy3BrrAdyrscTa+PTNvYOSHlEcXngGCBXhZ3hjjzuXAbOTVL2ZyCn20rvP2CsHZxiOm/sV0HSG5hxEthXnGPYDudMEw9DUO+9M1HiQqMFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756328; c=relaxed/simple;
	bh=jfJ5x0vGKsIitODBYFV2Yz089sI/+XlCGVJhVoEJzbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyDCfS8Yjvf6gpstRQIHhGNFDepGtkPPCmQVi6q7D1hlUzGzSIrK+PYXbeNU6FtCXvi1UkjNHfx+sI+dT5ZvawHuhrUkZFpsU3NvNcHXr2eCUHrqpkr9NncKHHrxoZCI/dv5qpSTLYdJFv1DI1FK19NsvSWZ3rPaWWCzmMAyFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw6ieSbK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46c7855df10so41973871cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737756325; x=1738361125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWhrvIc4+D7GQdZ27jsSNqLK/xmE89oNOMh/DC5OGss=;
        b=lw6ieSbKl1krkTF2VovyDjermZl8BQ/y0IZxMrlpI0qPCHu2Itf0DpMWd7nZTQ59TP
         ExTZzdN2jMxnCbWpUDUUf4scTX4qKQI3RfMsxYnZ/zXJnRj/GJMx3+paixESDI6Ypqyz
         xZeFAsf28/PTOZHAfO6B8vatAw2TRmEy21duwl1p5HEMQSp/MGy3GzVurkbXtNS0/L+x
         cyj7qtmZQqAQTA5bioVm8K7Gi0v2puuBjHkrObv/oS+nKHyzyVzqz6gOezf2+3/8qm3r
         4PGOy3j/dgBadcyXEHzuUAA8cDroArBb+XeFBok8+1XwiEufU2kIPzkEyYMyNIGNSqPh
         eIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737756325; x=1738361125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWhrvIc4+D7GQdZ27jsSNqLK/xmE89oNOMh/DC5OGss=;
        b=XocitbqFAoTC1jNMHLbXVmRqv3BzT8gX5Myfra1X0glluP0E/aIXfw6X1oacCXRTLQ
         FkayAJLVM/KXMqOCtNU6cuiesFg69WAUoz8uV5SfzObHxOIW5wAEpL5z+rFBWbXGsDb+
         cHuHBfwCaNViq65tKM4Bb9ci3gnV7PbTIKPEckA217UI0QjihFXGgfSKLq9HrdU37rLF
         0FaVYwkv3ZN7GL0l5JFQ+xWtFL7nL++k2WlTZVvdxKeO0hnXyosZeSwTwjrwnWtWiZTR
         UBdXO05smu4VMkq6YOfyuFPA7QHETvrQV9m22sLy8YZpoaQcnaw7SzKtnmGNLr9VZ+EP
         zvpA==
X-Forwarded-Encrypted: i=1; AJvYcCUCgpkSrNGZx13ln4TEBURC28sMwR9Uq6bzeHwr20qQn4V+PvJeNVCxWQL1zSThvkgIJz/iGHlQQS2f29H2@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvqXV8B0+NMq6s1ry1vpEKwcESKjG4LS39Z9uPetzhx7ue693
	9AV6qzi60xC2ZatmR66n3yCdULoP8HEIztxcr9yJlfH/MR2UKFofot1/I+gmio6vE7dRi/fDVvx
	3TpqakSSzb/OwJ+EKIJXW6DT5in3sB6WqUPI=
X-Gm-Gg: ASbGncvSB62FRTu5Gyw/rUaV9jEo3NnEXGOfpXDa2IvwUX1CRMa3pqG08Ms2myGeS3S
	qryAU9LjBE1dKs2kSMbuttOlYOf0qxLIOvlc3M2scjWbiNFsXKSGHhdFAgbYJUP2OrFBxnlfquQ
	==
X-Google-Smtp-Source: AGHT+IFPJYBZGR4WFOoCUrWEx8v45SLHvsOWnxTlC2PY+WovsyQszrXldPO6DGTCq0wkp+xJ4J9DK2tSUFaSjJrrn4Q=
X-Received: by 2002:ac8:5a15:0:b0:463:eef:bab4 with SMTP id
 d75a77b69052e-46e12ab7ad6mr444132451cf.26.1737756325231; Fri, 24 Jan 2025
 14:05:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123235251.1139078-1-joannelkoong@gmail.com>
 <11f66304-753d-4500-9c84-184f254d0e46@fastmail.fm> <e7dd6a74-ddd3-475a-ab31-f69763aec8ea@fastmail.fm>
In-Reply-To: <e7dd6a74-ddd3-475a-ab31-f69763aec8ea@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jan 2025 14:05:14 -0800
X-Gm-Features: AWEUYZlRUIBJ5CEttNCC3XP4UYz_4-ypb_6rf8qHkMy0GoVUvKzs_XpW5oSSAhQ
Message-ID: <CAJnrk1amoDyenJQcDbW_dcsHVGNY-LdhrRO=3=VK+tHWx4LxbA@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: optimize over-io-uring request expiration check
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 10:22=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> On 1/24/25 12:30, Bernd Schubert wrote:
> > Hmm, would only need to check head? Oh I see it, we need to use
> > list_move_tail().
>
>
> how about the attached updated patch, which uses
> list_first_entry_or_null()? It also changes from list_move()
> to list_move_tail() so that oldest entry is always on top.
> I didn't give it any testing, though.

Woah that's cool, I didn't know you could send attachments over the
mailing list.
Ah I didn't realize list_move doesn't already by default add to the
tail of the list - thanks for catching that, yes those should be
list_move_tail() then.

In t he attached patch, I think we still need the original
ent_list_request_expired() logic:

static bool ent_list_request_expired(struct fuse_conn *fc, struct
list_head *list)
{
    struct fuse_ring_ent *ent;
    struct fuse_req *req;

    list_for_each_entry(ent, list, list) {
    req =3D ent->fuse_req;
    if (req)
        return time_is_before_jiffies(req->create_time +
                    fc->timeout.req_timeout);
    }

    return false;
}

and we can't assume req is non-NULL. For entries that have been
committed, their ->req is set to NULL but they are still on the
ent_commit_queue.



Thanks,
Joanne

>
> This is on top of the other fuse-uring updates I had sent
> out about an hour ago.
>
>
> Here is the corresponding branch
> https://github.com/bsbernd/linux/tree/optimize-fuse-uring-req-timeouts
>
>
> Thanks,
> Bernd

