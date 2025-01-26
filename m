Return-Path: <linux-fsdevel+bounces-40134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9233BA1CF06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 23:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1442166A5C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17513959D;
	Sun, 26 Jan 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg4N0OCE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5315D1;
	Sun, 26 Jan 2025 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737931530; cv=none; b=tEMlYwKADl3qO9DBKuza8Ci4DJLYbRm95V+KUzAH2nzCnJLwpGrBt5Ns1iq6mNYb899UxxjxcwbIXrRdRNkARtG7ZakFivzAKAcVHqnS+8tdIk9VYsYEB7kcf6lkKiY+hSweoKWnB7yP6FDTfXfULltDsSJNxsgzoG5G81cPCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737931530; c=relaxed/simple;
	bh=UIYY+WmW9/MvrN4P0LsEG7nmCoW9IpP+t9BfSR4bKv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMf1CDMdZtavhH4lulaqrga41YtYucsMUxbDLjH8JfyzQX553sHlMlWY6d+QVMPOf2nCklupJZt6TQnqFNmND9ZCxWwOTDh0LNZ4oy3rwI/wjsEUpFX8IzHSsLrV7nzMug0xBfwYeLlshjKl2+FO2uRGd/PBD7EudjyLiwNqUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg4N0OCE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc0522475eso7556319a12.1;
        Sun, 26 Jan 2025 14:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737931527; x=1738536327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIYY+WmW9/MvrN4P0LsEG7nmCoW9IpP+t9BfSR4bKv8=;
        b=hg4N0OCEXQq4B7Zxb4Y016E1V/6Y6AIZFpp5+UWpW8X2TKVFt5lKzW0EK3OGCgDCyU
         P1MJLOhpSxyz6nUBJsG7+FvJ+c738+VAmuFxJh+ukD6M+sRKiRFOj4K9yAXx7Zj3GzUt
         lwm8Sj60mq8wp8MsgoeXB7b9Hk81iP3crxUakGy4y/yG+jsAN9pZ+edlNa/6uBraoBMq
         rpQZ1vhp9JcoqBngl2qQeNJzW2EjUPE466gfOT3PaE4gb1uh9z9NgmTcNCL1kVxKNz4L
         GEKiz1KG7bMrCSngctop5FYVc6TYqiXXatv+JNotxaXHrebQuZH0Gnx0DoaRVC8SAHX+
         UpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737931527; x=1738536327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIYY+WmW9/MvrN4P0LsEG7nmCoW9IpP+t9BfSR4bKv8=;
        b=ZWtKAPfDKiyrjnJXcPBGeNgf0jx3Y0ov7sYtNho3X2kZL5c5X9L1gRjie2Td2wEIOk
         OgVzdfQ53i+DWEPHHLTaBxxOR4wSA5bXsgwakHNXRXWvBYMGxSXvAJGPVU9xjqZHO/Iq
         6qlTo3D15R8JkLbih0/AkoOZfMo5HRh/uWB3gXO30ry7DpGFroys9/gMNQ1Df3nqW3Ce
         RMS+2s+GATSgeFDDvCJ0Rqm+z0d7fnDEOdmfR3hibgZmyOYEMH/b6daWFuH0dwyFIxCU
         7bcBRzW4KR5JszzqJpGeVS1VC/mtnd+nUxkv6Hj4U+ituhZOFPnFTO7uXT2a2bYeNzOg
         WCBA==
X-Forwarded-Encrypted: i=1; AJvYcCU5xv+NeM6SaBn7zWxeKI1bnbzuNlyWnjvqK3UdOtupv1E7cpBhHx1v2yz2woCJVE2AVW9YKpdC/CF0Bkdm@vger.kernel.org, AJvYcCUzTYxSUhnsVXi/rzAgBqKbzjjANv6FFRaaKkfuie1HynVgqnZytzx8Kqu3Tx+jWQZ5WNtgg+nR3Lrjl4IIsg==@vger.kernel.org, AJvYcCXiGrkKZ65azawyieTc5Ku4M2YBnYcx1rI3dwGtKvsNY72tTj7izN3YFbbFKDAkuX4c2p8lIgzQ2bBe@vger.kernel.org
X-Gm-Message-State: AOJu0YyluqxrGFY4icM2B3C/8kR/B5hpx/6azG9WwLNs/+jCn7TXcMwH
	KE7ebTft5nkRfm613LtcOGNIRad0pTHT6m+wUfeQSYOiyHGFk10V0gdfromJJoeo2YPZT6qTg4e
	743CKBk5fRekahZ4stYDa1US6ZE4=
X-Gm-Gg: ASbGncsVkazn3gLbM332D9q2E34BPjiIR+XVuwfAJ0eNIHzxzDGqDNh7oBlAOlXyo1u
	mEb+gVjRnGwht+MyRpAKb6P7zaio1EeKQV0RdyI3zIgOgqqwwbNqRBGvw7rBM
X-Google-Smtp-Source: AGHT+IEwiYt38FiCOzmbRphQ6ojLMtRR9hEgo7qm/0HwGEa4UBFGLm4hhNykMw2bqZBJBAr41SLwOcDBPTJ0aWVKyJM=
X-Received: by 2002:a05:6402:520d:b0:5d3:cfd0:8d46 with SMTP id
 4fb4d7f45d1cf-5db7db2bf02mr39155167a12.30.1737931526431; Sun, 26 Jan 2025
 14:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20151007154303.GC24678@thunk.org> <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
 <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
 <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com> <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
In-Reply-To: <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 26 Jan 2025 23:45:14 +0100
X-Gm-Features: AWEUYZmUu7JhLARBOZfRP1C3N99NWIolyPIuQXUQTkRydBH17YuxkQT9KxX4Ez4
Message-ID: <CAGudoHHyEQ1swCJkFDicb8hYYSMCXyMUcRVrtWkbeYwSChCmpQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>, dave.hansen@intel.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:03=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 26 Jan 2025 at 11:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > This being your revert I was lowkey hoping you would do the honors.
>
> If it had been a plain revert, I would have - but while the general
> layout of the code is similar, the code around this area has changed
> enough that it really needs to be pretty much entirely "fix up by
> hand" and wants some care and testing.
>
> Which I am unlikely to have time for during this merge window.
>
> So if you don't get around to it, and _if_ I remember this when the
> merge window is open, I might do it in my local tree, but then it will
> end up being too late for this merge window.
>

The to-be-unreverted change was written by Dave (cc'ed).

I had a brief chat with him on irc, he said he is going to submit an
updated patch.

--=20
Mateusz Guzik <mjguzik gmail.com>

