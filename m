Return-Path: <linux-fsdevel+bounces-68522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F234CC5DCF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B163BE348
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666AE33555B;
	Fri, 14 Nov 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+LswVkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752C334C31
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132576; cv=none; b=Z4F0nCOH9hyG/eWlbg2fFDBGCDfXe9nBUB3iQl6OBe+YbWYTzpzLEVQmeVOfJNL+rE15vkvYBlIOAJ+dcW8JciOiKpQJCGY4gLX4ErHSKn4skslLBez2xvB1oI02XyKNd1N2GdQuwtHAxciCs5Uy9rfKCRF4k9eke+LkC7mg+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132576; c=relaxed/simple;
	bh=+l+hoYBLjww8zI/guQgOAqxC8EnCLsSCBWNVebs6n3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWM95ZCt9RoSC5G2sV1ZTdhvQ0wBUvl5hYbN3uJQVxamZj7sbL4e0g3Hr9NeOUThzPXSARBlLPpNcRRFJgipdqWPx1oRffgSdLPJLYF7YIyybuEepUbMp09KB1FHZr9d1Dj5CfSbldJdnUTIly88Km5y47nykTimBvdX4IpKXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+LswVkK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4777a96d817so2933965e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763132572; x=1763737372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1X8Q2S4O2sZWP6G1F98UMapGcvaFv7Gky+IoouKF1g=;
        b=i+LswVkK3q6/JCO1dqCsm3LCL672OUeuLUr4ED1q4NGxUMkoetDstXnH6CrEQSGcwn
         mANjFN5lS7BwIr26cGdqHXgL5RPgFN8iLlzUZh4Bkp7jLRhhnoVhGkFwV4wAOkyVwBTz
         uX2qtD/1GiF2ULLLHO5LUqn58AoPCQdzQY9J0I5cbHEpVvB8oKY3kkvBP2KHxsxpNZEl
         oAMtnmeVXqOr/8TDCdkrGH11A+hS4mZkJsWtZHrwhENw1zIU4eFHKTO2Ld8/jQtn5k8A
         nRvsklLNmPq2eBYTnAjhzK0UtbIsa+FViLsSp9I2FSh38BLTBdvhyj2HC9gOwNk1BBlq
         i0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132572; x=1763737372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1X8Q2S4O2sZWP6G1F98UMapGcvaFv7Gky+IoouKF1g=;
        b=ssePKZ918tAO0sTfKoIDKmPZQDGyb052n1a/xtKYwyF8mSBDTPjeah2n8zJJTahqk8
         W/iO3gIDLGNTYLjhszgwK7VVjwLoJxh8ZqhY18QeyAZmUww3sWnnnccul2EMW4+SGN3U
         Y0MgMVZ/PhlWMnWw0sT/+IpkUhvi9ZTRHIAR6I0BYEfqdZ8eQs1uMoUFIe5W4pQHSGyq
         79mB+vUBJ6zNKSiJCAllyawGb2F5eRrxLo0hNMR+Dt4H2qLaFfr2va35FOY6RHGVEw3K
         4bFf1v8VLYhyt0a7htyaqbnCdStdqKjTaw+Tw1mkzO8Dema+pqmzWQB0Dhfl4xctgTTv
         B1CA==
X-Forwarded-Encrypted: i=1; AJvYcCUyl9luW8uS3SCBafpjnSuRSZTvyd6QlJb3LQ/lknA6YmLLDDvQA7Vpw+LIZ/POWmKkGM27U9AJ6JYqkAaD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyin+F5JVQjmSyDYmMddkB1rn/5bS7dFxYzqnq0nizfs7M5yLfd
	ClhomnGyh+FlJOCm1eH49J+lwsXRU34D2DOvo1qt7R3qLdWlkvmy2c6r
X-Gm-Gg: ASbGncvMneQKr7Rd3Jqc4gSmqiWb+IuIHNsAlHJU90q0EIMufiW4xx+gcksyFLeEgys
	BX7tQFqEf7TpRvuy5AWagZuw6XAfnjD4On6mCbuAiMGVFwFjpavB2Wkx4dWRaEJysSgw3Rc90gg
	s9qv7A5CsfSyHVgcKlZlZNY7pVJ3y3lkRvNIzt0MkwMOQh1Vs+m4GlRW7n5TmecfOy2JTVjdjKi
	RZ4rL5h9dCzFk2P6LG0E4iJsTFatXlilfI4Dn2a6v3SJ5HIUo/8/KtR1ZgXsuq6VLxWnUlQiO2O
	1cSJvo7Vy2MxBY1VVBqOepQz8O4sG9quBi8HkIQVHlX8dyVr2eLCbtaDh8HfVVu5sYUR2fDVimr
	1Q+aTkbYWLH+m2pZ2W/QL4DVPXnULWOENxNBTOUkTSaAHqHQLEQt38S2vbtuN7UadfyoHhGoTJe
	ND1w5v4Q==
X-Google-Smtp-Source: AGHT+IEyms2C7UzZHoZ5Qwo32dMY3nZz/LAJjpluGuj0h6V+1ukbhu1w3hDAk3zlXWqLewSn4eTm5A==
X-Received: by 2002:a05:600c:3114:b0:475:d7fe:87a5 with SMTP id 5b1f17b1804b1-4778feaf8b1mr18350065e9.6.1763132571611;
        Fri, 14 Nov 2025 07:02:51 -0800 (PST)
Received: from bhk ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd25a1csm47378905e9.5.2025.11.14.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:02:50 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: 
Date: Fri, 14 Nov 2025 17:01:26 +0100
Message-ID: <20251114160222.469860-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <69155e34.050a0220.3565dc.0019.GAE@google.com>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..8fadf97fcc42 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1690,6 +1690,11 @@ int get_tree_bdev_flags(struct fs_context *fc,
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
+			/*
+			 * return s_fs_info ownership to fc to be cleaned up by put_fs_context()
+			 */
+			fc->s_fs_info = s->s_fs_info;
+			s->s_fs_info = NULL;
 			deactivate_locked_super(s);
 			return error;
 		}
-- 
2.51.2


