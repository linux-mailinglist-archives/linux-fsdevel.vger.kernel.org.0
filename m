Return-Path: <linux-fsdevel+bounces-33683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B49BD2B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F361C20EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C55F1DAC96;
	Tue,  5 Nov 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at77DxNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0C166F1A;
	Tue,  5 Nov 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825070; cv=none; b=S4DNuQGYfVuSRzjKvyTeZ3+7wy9bUTKuEcDu2bZMwMwHS3fg3ti0nbaX+2cMUxxlgcmyT+EVM546bs5Dn8gOCvKBDrdYugNZ3yDCaKueIFAIj+j/FeK6RPsNNamvNqI1ab9gRAi7THyuSfxdvYK+oxInsmY/wAMv4QWbnjNhfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825070; c=relaxed/simple;
	bh=xoo0q5V8wjvE7q4lC7VQmHKa9nUZeAijOvblSEeRZm4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=uwgAl7TaApjTRjjSyGPXEdkTWsUrGSatIHrO8OuCsy77KwuAUAEjP3EdZAifnWbqrHQVAtZBdRaRLDqnsDatGyVgkJcE3IZKYvjkEjTJZCTH9zM5ZftszTLNv4qSNqBdyCMaO7ZXcF5EKQ5O69zFzNaWh/c4Yfcj4si4NhJV2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at77DxNn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e52582cf8so4907458b3a.2;
        Tue, 05 Nov 2024 08:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730825068; x=1731429868; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3rhwRI9JuhsZtMEiJ0JD5YM4F04aW09mvO+gxbR/BxI=;
        b=at77DxNnUCxbQ9cfuKwfPifgxOpb83UMSNzKbDVc5puFqhu5ZWy8GdWuC7ejCIbLyE
         Ww/baMcPVcHd3WlNNzxKTPNlIoCPLgtGZ9VFj6Sr3S0mTbS3J6cc1uGsxilA7Pq9Hh1Y
         32Y2iw9bfpvAU5mhXRDzAldxbT1bbeexNkw4NgID4/2+mM4hG0p9La3/IyHG1bhhIiJW
         CyaeRkWBhijSlP0k2L9cU64FrrPoLFt2hK3mHoEom0rGhisMTNALBEif1nRMyID2rrT4
         f4+sSlB5UqSLYZI+xxg+rixiCeWVMHihutuqhNP+y6gt7oezBQzL8NziG9JQv8i2Tf5g
         IEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730825068; x=1731429868;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rhwRI9JuhsZtMEiJ0JD5YM4F04aW09mvO+gxbR/BxI=;
        b=ZIF4qmJKo7X3vef2CMyPcM+Ap3C+NGcI27YK4NucVjBJbzt77JrgEy09FBReUA7Tgo
         Xk5DKLFi/KqCmQgBdgDOKjCU8RllE8pdGmtpIwwl1pt8sdLzLrYI4PZLkv1zENG7Qtb/
         3fTv0kPSyJ7OZiwoXQuUZ1hQvhkTNkBzG2rdDn92ZNvF9XV2s5PrdCFKrUqbUxM8084k
         0VlxFuFKZj0tzudJZN0GnKt9rFuiM1Ifx6X+4oSgVHSuWpSY7cg6ILSODwM9S68i0g32
         eIdauYEXqZTMRexZfknnWM+5wK5x3Lcy+ceqghCdnF6qRpUsm9PzvondoBC+Bwr9dw4r
         2fzg==
X-Forwarded-Encrypted: i=1; AJvYcCV4vbPPcpnBqTayBhFieG1Gqd7SSRY31Iqnzzt/7mgw5L/f+OPc3L1s+pZbtnWi7Kq1wjADFXaU4e5PPv+8DA==@vger.kernel.org, AJvYcCVPiFUi9HO/1dhHwNYupNbGlULRQYuxE5irBO1O7BIs8qdIhdxHTUBwwcFn3CHP9NXd0tLwKtTQ040H/Wmm@vger.kernel.org, AJvYcCWkEdDlAsrst4pZc+bh8L53mdDfbRZuyCy/tOf/EqjMHYcwLEBuFXzFSVHHCgYGTNCm8Si7V/JM7jH3sA==@vger.kernel.org, AJvYcCXVnjlR5hCE2Rvl6JDuFsMjfTsm0vvR7LU1L9/HMyffbyIl6QdfQYTFVXwQ5K7rX0Xy4LewpVUHbMbu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BF4oYAIHyiq0lX2zTF06FHJPFWQQMvdi3Rv0SlSawciZMYfv
	00vppsddv4DOToFVBvYp8lW1cMbfrQg72EKEETZQMP8zXEQ66gS4bStqHT6q
X-Google-Smtp-Source: AGHT+IE+msBBk5xTD+37yuN0TqDTIzB8QG+0iDim6ovw09YJxH9+iCpRyCjKlpFHLHdMZJSNAaLlBQ==
X-Received: by 2002:a05:6a00:2d89:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-720c98d32c6mr23148208b3a.7.1730825067732;
        Tue, 05 Nov 2024 08:44:27 -0800 (PST)
Received: from dw-tp ([49.36.182.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb586sm10159932b3a.149.2024.11.05.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 08:44:27 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>, John Garry <john.g.garry@oracle.com>, brauner@kernel.org, Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] work tree for untorn filesystem writes
In-Reply-To: <20241105004341.GO21836@frogsfrogsfrogs>
Date: Tue, 05 Nov 2024 21:56:45 +0530
Message-ID: <87pln9sl2y.fsf@gmail.com>
References: <20241105004341.GO21836@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> Hi everyone,
>
> Nobody else has stepped up to do this, so I've created a work branch for
> the fs side of untorn writes:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fs-atomic_2024-11-04
>
> Can you all check this to make sure that I merged it correctly?

Sorry, I couldn't reply earlier(I am currently on travel). Yes, the ext4
merge looks correct to me. You have taken the latest v4 of the ext4
atomic write series [1]. 

[1]: https://lore.kernel.org/linux-ext4/cover.1730437365.git.ritesh.list@gmail.com/

> And maybe go test this on your storage hardware? :)

Due to limited connectivity during my travel, I don't have the access to
the hardware. But as I mentioned the merge looks correct to me and I had
tested those patches earlier on Power and x86.
But I will in general re-test the mentioned fs branch for both XFS and
ext4 once I reach back but I don't think we need to wait for that as the
merge looks good to me.

Also, I noticed that we might have missed to add a Tested-by from
Ojaswin for XFS series here [2]. Although Ojaswin mentioned that he
might also re-test the mentioned FS atomic write branch for both XFS and
EXT4.

[2]: https://lore.kernel.org/linux-xfs/Zxnp8bma2KrMDg5m@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/


-ritesh

> If all goes well then I think the next step is to ask brauner very
> nicely if he'd consider adding this to the vfs trees for 6.13.  If not
> then I guess we can submit it ourselves, though we probably ought to ask
> rothwell to add the branch to for-next asap.
>
> PS: We're now past -rc6 so please reply quickly so that this doesn't
> slip yet another cycle.
>
> Catherine: John's on vacation all week, could you please send me the
> latest versions of the xfs_io pwrite-atomic patch and the fstest for it?
>
> --D

