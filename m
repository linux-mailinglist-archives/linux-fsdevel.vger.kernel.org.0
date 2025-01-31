Return-Path: <linux-fsdevel+bounces-40495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6430FA23F02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 15:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FB07A255E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF821CAA92;
	Fri, 31 Jan 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8ZuO3j9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78E1CAA8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332818; cv=none; b=Yi6lu71URdlv0wLeXpfeYTFB4m0juoKqiQAzIpHylruEuDUUL5yEPk3a3kflStGalr9i5/Z7q4EEDsbGvn4rodOfFIiLRwZJVMogItxBiEB5jazr/VFGERAnkzu7eUFepyqe6nz7CLdmdoZyIqf3NNxLg1ywkzP4M9J24nzwogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332818; c=relaxed/simple;
	bh=HDsbtP43ez2FetVb2B+hPM0c9da4FH7bKgAu+7KHljs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZ9QJJxobU8Yr48CKGjsm8EJIXq3lMTx5S6IgDzGddKfdTSsI4WjB34yz2VR/mT3W89n9SofdJHovxHHHi/vjgI/sZ5KuHEbWGpQcBBYfLyb26r9w1kU24Q9it7ifg17XVdKBLut+GqieEqOlXZsCH2ftG+PxuKeVWZrmKjRXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8ZuO3j9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so3565326a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738332815; x=1738937615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDsbtP43ez2FetVb2B+hPM0c9da4FH7bKgAu+7KHljs=;
        b=a8ZuO3j9dbfKpHu7rsueUM9jUPeMSAaDS8XgDKhSK5YR59J0+bBpcMfPTyo8z8knBd
         beGZNZmvOSyOgkPi0A16k84SJ1An1vsboPwopHLyZfHm21ZrFzW7UnDtaG8d3waTkx5U
         17a9G5gSasHJovWyeDP1IzVNDikBzaKElAH0SAP3hz3htHK8F+KvQGN9EZLK5MD7s3hZ
         eUZlNypJdLf8iayOR/kc3LVE1RbzvRH83LcmhflK/XPMcxur2nX7bO+egMe5KRAk5Xc5
         QzWjkZkQauJwrUNACP8kbqcDKpunzFVTrDW5ltrBFv68hzyBno31J9BhiqzeoDcxgYqx
         80Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738332815; x=1738937615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDsbtP43ez2FetVb2B+hPM0c9da4FH7bKgAu+7KHljs=;
        b=l0OrPVr7r0Ot7zgC2l6tDUm1OX76SfSGWxbmePkzZDNLgAqrfboqzSW2m82OXmHcK8
         +y3gqcg8iE1oW3b5Zu2laiQCiczvb80usWRzrtA8qkkFdBtgwANurSb4fJ3jCTPi3RT5
         54ZvheMJSUvUDyypS16tn5vHryXiv5+b9NPSDECjp385677avS6wOaO56BLNIVx72anb
         UtjF7k5jMy2q3U0/D1xP3OTfOmBti0EyMgknlpTsdLFLHQsyrIhAKfAyvBqJz/QFh7Q3
         MTfmItGNnwwD7zM2tiKkpnl2ftsgOAzFYhKcGr6iDvFcTLu3l/n2ZvqjLcCdvY/fd7yh
         Ll1A==
X-Forwarded-Encrypted: i=1; AJvYcCWLZxCQl3iJDFcMkdBwxzAhVqePJ4fhaeKX7duzxuTPqRoLWYZbhjAKWp4IIl9DTYbXpFHdBXrFC3jEpnsF@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2QiGC4NZwUVBH4BrZGSPH4aRxRJ7aX50ELGJJPnGInxusslK
	VmpAnEihffmjTYdaRmPJ3O8RWOkT2gb/wINnq1z064LrOnwf8ryx8I0qC/mfV1vS9m+T6X8qOE4
	Nna/0QHO0KzTw3y56tMh1u2jwU2U=
X-Gm-Gg: ASbGncvhtxQ1gsWLi2/R/Glv3g8SXqX3WuEUMu4yNgJPOUD1fH4bKZ5zOvWFxRfqQ+l
	N5ZJoceOjjKDMmLtc4+7XNAkzuPDlxv8LVrZSf8QE3L9dNvHleYFHs8q0vdKV+CjMRnG1eFeg
X-Google-Smtp-Source: AGHT+IFLF3DufGNQzHwWIGiZfzJP0e81FZu4BLhvEtYDEzjRXjmrqZQYzD3bgIz9G3cE7DB8AcKdx9OTx0rZRVaN4Ew=
X-Received: by 2002:a05:6402:3595:b0:5d4:320:ee66 with SMTP id
 4fb4d7f45d1cf-5dc5f031385mr10968986a12.31.1738332814512; Fri, 31 Jan 2025
 06:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk> <a3741a38-967c-44ad-9e73-64628048027e@ddn.com>
In-Reply-To: <a3741a38-967c-44ad-9e73-64628048027e@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 Jan 2025 15:13:21 +0100
X-Gm-Features: AWEUYZlHRkvQe4TG55Xzo65_q6TEKZbCf4qhSXciqAwSmpZdr7V_aWc5SYs5XkI
Message-ID: <CAOQ4uxg+4xrdCFgkvKHCvdbKwS9yi5_CPjM0Lwprfa5YZn0UEA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
To: Bernd Schubert <bschubert@ddn.com>
Cc: David Wei <dw@davidwei.uk>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:06=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> Hi David,
>
> I would love to participate in this discussion and the page
> migration/tmp-page discussions, but I don't think I can make it to LSF/MM=
.
>

Bernd,

We will do our best to make sure that you can participate in this discussio=
n.
Worst case, we can take a small room and call you with one of the laptops
as you guys added me into the FUSE meeting in Plumbers ;-)

Thanks,
Amir.

