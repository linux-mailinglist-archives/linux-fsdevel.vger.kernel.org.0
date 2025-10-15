Return-Path: <linux-fsdevel+bounces-64194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73483BDC651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D091918A7750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 04:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F28E2EAB64;
	Wed, 15 Oct 2025 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXbSZlaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691C2DC359
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501003; cv=none; b=JxvloBumRXkhS17/dxCyxlrC7TvxTCKxIMbW8CuLMurAluqRcIFZ5Ztf2kPUAsTkHTmcawnhMpzKF0D5Bq+Et1p6WgkUzz2kVJbyb4Q+UruGh9g56nrVbc1sZOF+QIeEjAfMVvwTsS4Q0wF0B7GSzU58nC/SBNpoeZYXPTy7g44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501003; c=relaxed/simple;
	bh=p04wSVedq5RYaX5Nmz9HRn5PNrsa31BCRLo0sVIHALg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEnMQsR3tDIZKGWPk5Ulx8kayyrwuLm9MiL8q6hEPwyodTnNfjHooA3v7qGFBnmQgH1la4b26h1Fjoi//mDmu8BXWrR2gOXokSHxHhor4040S/0Jc9fPUUB5AaTD830yZCmHCr5mQllQAASLQAZzunJhpP1a+tLawTNYrOk6OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXbSZlaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F0oQPy6sJALcjkJ1xdOgR0v6F24g1cMKqTRKvMpDOSk=;
	b=HXbSZlaXoZWg3E+aqUweX1MXrHLK7Zf9igE7myOKqWGFzu0Te2nf9WtGKPeUjXnYfmNK4D
	nqKJ0OQVTfYmsEaKk5fDIPrpXrkV0YRQGPixQySz4RfDGMJLeQ3ZF1mq5ffhcLSt2vScWj
	BKva7qMbTp3EtMLZeSFMI8ji1L63Ks0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-NCk8ql79M0OHntH9WBtmww-1; Wed, 15 Oct 2025 00:03:18 -0400
X-MC-Unique: NCk8ql79M0OHntH9WBtmww-1
X-Mimecast-MFC-AGG-ID: NCk8ql79M0OHntH9WBtmww_1760500997
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so16379365a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760500997; x=1761105797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0oQPy6sJALcjkJ1xdOgR0v6F24g1cMKqTRKvMpDOSk=;
        b=nnVtFfVFTPgoX/n/riHATal8ayIrNITVyZSM90r89i3/zrTLMbAOTxqbk+gsAe3Jw4
         nj3axpVWIvMIZ8vyU8aL+JUQGuotaZVWIBdCBK/uhV05QPFQvTvBVlyo0h+ahnL0xT2z
         aXHNzQtiZkRw4in633As+/hpLiCpM0cJQTdNvWDoLQFDy4/AwB0PsLQTbstfnMWxcE1V
         nBy9M4zc8w/5jZdtR7+q8BApTjobeN2DW8zdv6VSnGVli8bI7nRgQVcK1RxJAlOwgiCE
         Z6pKQEbOMAYIVr2CIdChzVlg+tCceDYcSyavuljW7D1fojMwy++nEuKNOOFDkRuei3O/
         jxUg==
X-Forwarded-Encrypted: i=1; AJvYcCUCnYh9HmDp/nTrCgsWUZMVPUvNtJjxAKPwgvY2xqGrb95falNmaK1SrbU/L77rIF0q7Q7JcHVWILojheb9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jD+RZ8C4C6vmyz81HaqyJBxCubeWmUw+0F69nAVIiVSZlDx8
	PNaMkqq5WMeeGTx6mJG8rj1gXdWLPdVT2UgXq3p7z9iOu7QGAAhXVgypnOM/+MntWHwieLpSVxt
	/R5y9hpBXkyTCsBj54WS/o1+RkQ3IBwwX5zuMvMs0Nm8fL59/4pXoVa0cOCJv2IzjXNw=
X-Gm-Gg: ASbGncuFgCMwA31GAbjtFOfP3SjIXr6SY/5JEkFXisxeclLJ87KWD/0H/fzq7gf/F4F
	W2jpggTSa+cPECv1xfNFd+/YLw2JQ/Z6Oik51zc3x6poZpV/wkFtB5wc4PIKTAHqEoLyD4qoYoM
	NbCm6GtZ1tVM3+7qSgOUkjMgLbI9zNyCqxxgo0oOtIIJ7faiG0MJYpXYtsL3Pj3FZ3xY46/FirM
	GDBf3uB/z5EGsGQMxzuHbzf9MsAa7oUAaUWZr/jDt74VmY+Nwtl9qb8uA+Em9xwQFpSpwkWP4NF
	MCYRruWZ374GdJ79XXGDrlW/OKa+mVbi6o4=
X-Received: by 2002:a17:90b:1806:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-33b513cdaf5mr36389069a91.27.1760500997139;
        Tue, 14 Oct 2025 21:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRFuxW1Voy1mECvxyxh5CgehQPp4dDoRICc/mU73XzzKeQ5F8jWZeJJVvKmOuyelAlOt4irw==
X-Received: by 2002:a17:90b:1806:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-33b513cdaf5mr36389041a91.27.1760500996718;
        Tue, 14 Oct 2025 21:03:16 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:16 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Date: Wed, 15 Oct 2025 13:02:40 +0900
Message-ID: <20251015040246.151141-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series add support for the llseek file operation to misc
devices written in Rust.

The first patch introduces pos()/pos_mut() methods to LocalFile and
File. These helpers allow to refer to the file's position, which is
required for implementing lseek in misc_device.

The second patch adds the llseek hook to the MiscDevice trait, enabling
Rust drivers to implement the seeking logic.

The last one updates the rust_misc_device sample to demonstrate the
usage of the new llseek hook, including a C test program that verifies
the functionality.

history of this patch:

v2:
- Introduce pos() and pos_mut() methods to get file positions,
and use them in sample programs.
- Add read, write and lseek in the userspace sample program. 
- Remove unsafe block from the sample program. 
- In this v2 patch, remove SEEK_END related codes from
a sample program because it needs inode->i_size which has not
implemented yet. The purpose of this patch is to introduce
lseek(). Since implementing an 'inode wrap' requires more
extensive discussion than adding llseek hook(), I just
exclude it from this patch series. I believe that whether
SEEK_END is supported or not has no impact on adding lseek()
to MiscDevice.

v1:
https://lore.kernel.org/rust-for-linux/20250818135846.133722-1-ryasuoka@redhat.com/


Ryosuke Yasuoka (3):
  rust: fs: add pos/pos_mut methods for LocalFile struct
  rust: miscdevice: add llseek support
  rust: samples: miscdevice: add lseek samples

 rust/kernel/fs/file.rs           | 61 ++++++++++++++++++++++++++++
 rust/kernel/miscdevice.rs        | 36 +++++++++++++++++
 samples/rust/rust_misc_device.rs | 68 ++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)


base-commit: 98906f9d850e4882004749eccb8920649dc98456
-- 
2.51.0


