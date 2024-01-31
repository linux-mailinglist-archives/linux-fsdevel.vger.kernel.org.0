Return-Path: <linux-fsdevel+bounces-9624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A050E8436E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D9CB2177B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5543E48E;
	Wed, 31 Jan 2024 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2+y4S0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679E2E646;
	Wed, 31 Jan 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682930; cv=none; b=hFhrZ56AjA0vpy5RLQuZt5qqfhm5kungF1Z/RxEIv0+Wi+Hv9ZggDPlepku7RxAMiI5v0y+Fp1cHqQaE9plitbEiEs+zbcH88NqV+C2lVm2Lk9Wdh7D+W3vInlfmbCGRm9FFBkDdk0875HKKz/Tpt/5WLiU6fW4/kUViMHBIR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682930; c=relaxed/simple;
	bh=yEjvk7Z6GPbDCyyGwiMHpYBOIdUYk+N36+w68bh6Hz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bcYQlJlO7WHikzN7J30fVVxhgZmzLUUHWhVtE5vdcLCbEDRgz5Fj4eZRf5GXw6UVqEv69cs0Gjw2BKq9ry0SzAya25UCCiI2QZmy8LdFg52r+AX+nWha6vt8v/JwBj8PYi+VqYiVDapmNfnt5fPhjW7y17NEmLP2y/KQVLLVwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2+y4S0i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7354ba334so34632785ad.1;
        Tue, 30 Jan 2024 22:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706682928; x=1707287728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FNDbQxqsKRXUiAiX60JWrb4aEqdgGBOkItcuuiOTjM=;
        b=i2+y4S0iyZKc9hZnfdMIPNwTy6ysW06MgGA3ZNw0Q80UEnKyxGxiSmVd1OGSs0a1ja
         hdSm5UdabSjaIeidLiuoUMh4pW3YLiMTQzg/5rIRqt254+kTqJ7JnAABwGQi8RsMV721
         aSf3dTf3yZlt+DzWnKtKaws5cXjODWwwnIe+7MA+pmFRUcBi712cbhCyNG2/myH0RiK8
         XsJXuyus4VprvIykvZ4FoDkb3HAPxDaRYs4PYQDC1d0Csk4q3igOjEukCa8Kgske6SdA
         X1kvlKbOWIYVf1rJdj6gTgnFjVv043xfk5ueAm7dilcHK7NtSbCH96sAm4A1tcsw3Mst
         XK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706682928; x=1707287728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FNDbQxqsKRXUiAiX60JWrb4aEqdgGBOkItcuuiOTjM=;
        b=tAGA4OR19ZK+AwuzKeTY+ycClQM7beHDZz8EG9gVyxEaO8zDDd751+xtHgIojT3A4c
         utldO25k+JMn1INrJjClK57woGAPUjG8GYaGsUbBluZOYJ7s62amt3FQAdPIBxhBtWMg
         V54nIEXZNKByQNcOn0Ov8ITcsBm1B9S+jJrAJdtEpR/egLFqevxG9dPZf9+UvCq0n5xg
         RuWZwlb41pj0TZ8/9VB79Gmr1QDbMqSvxUR3E/RUkfdQLFqAjUqX9ualWN1d1ChRL8b9
         ytA7oGvoepQdm2oswKNqExjq4TU5MAwf1t+Q/hZNbKFLdjuXENyRII+R2eVmAvF2GPgl
         RR4Q==
X-Gm-Message-State: AOJu0Yy3ZHB9tWyiqkJR48/2wcpRG3EldXHu5VkmP6P3kiJrDShqtj1A
	wW3jCeaoOS0mw6CxMqq8c9CJdMNmjX0gMeXo3M7jwiC6Id2Jfu8QG7fK4yllO4s=
X-Google-Smtp-Source: AGHT+IHkKBojmMalCH1abnDqSb8OlKrQdwRV2VK6rsQwWqWt33sERj8ftB0n3bMtJsEZF1Wz/7WcSw==
X-Received: by 2002:a17:902:6807:b0:1d7:8f44:45 with SMTP id h7-20020a170902680700b001d78f440045mr867077plk.0.1706682928204;
        Tue, 30 Jan 2024 22:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWX7TgSI8BRheelh05ItqYsgn40g6hBRIaTo+VNnT8npGQO/npnJJ5Dbz62dk7zNVDFAZ4tfWXenrWD0hHK7rM4L32sfdLfwmzqwSrzg01Jr1lI3TlA39Mj0VnxD0QMvYtNlwsSpgcXs4dacuFxIzRSUd+6oOqGP14QLijAFDJ/pZBca/bb+OuOjo3gPtB/bOCmYqZjJ5SZs5zxGkzExHdZFe26qW1t5xb3b2KfVQUCTbSExOABcg==
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id e20-20020a170902f1d400b001d8d1a2e5fesm5499160plc.196.2024.01.30.22.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:35:27 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: david@fromorbit.com
Cc: alexjlzheng@gmail.com,
	bfoster@redhat.com,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	raven@themaw.net,
	rcu@vger.kernel.org
Subject: Re: About the conflict between XFS inode recycle and VFS rcu-walk
Date: Wed, 31 Jan 2024 14:35:17 +0800
Message-Id: <20240131063517.1812354-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZXJf6C0V1znU+ngP@dread.disaster.area>
References: <ZXJf6C0V1znU+ngP@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 8 Dec 2023 11:14:32 +1100, david@fromorbit.com wrote:
> On Tue, Dec 05, 2023 at 07:38:33PM +0800, alexjlzheng@gmail.com wrote:
> > Hi, all
> > 
> > I would like to ask if the conflict between xfs inode recycle and vfs rcu-walk
> > which can lead to null pointer references has been resolved?
> > 
> > I browsed through emails about the following patches and their discussions:
> > - https://lore.kernel.org/linux-xfs/20220217172518.3842951-2-bfoster@redhat.com/
> > - https://lore.kernel.org/linux-xfs/20220121142454.1994916-1-bfoster@redhat.com/
> > - https://lore.kernel.org/linux-xfs/164180589176.86426.501271559065590169.stgit@mickey.themaw.net/
> > 
> > And then came to the conclusion that this problem has not been solved, am I
> > right? Did I miss some patch that could solve this problem?
> 
> We fixed the known problems this caused by turning off the VFS
> functionality that the rcu pathwalks kept tripping over. See commit
> 7b7820b83f23 ("xfs: don't expose internal symlink metadata buffers to
> the vfs").

Sorry for the delay.

The problem I encountered in the production environment was that during the
rcu walk process the ->get_link() pointer was NULL, which caused a crash.

As far as I know, commit 7b7820b83f23 ("xfs: don't expose internal symlink
metadata buffers to the vfs") first appeared in:
- https://lore.kernel.org/linux-fsdevel/YZvvP9RFXi3%2FjX0q@bfoster/

Does this commit solve the problem of NULL ->get_link()? And how?

> 
> Apart from that issue, I'm not aware of any other issues that the
> XFS inode recycling directly exposes.
> 
> > According to my understanding, the essence of this problem is that XFS reuses
> > the inode evicted by VFS, but VFS rcu-walk assumes that this will not happen.
> 
> It assumes that the inode will not change identity during the RCU
> grace period after the inode has been evicted from cache. We can
> safely reinstantiate an evicted inode without waiting for an RCU
> grace period as long as it is the same inode with the same content
> and same state.
> 
> Problems *may* arise when we unlink the inode, then evict it, then a
> new file is created and the old slab cache memory address is used
> for the new inode. I describe the issue here:
> 
> https://lore.kernel.org/linux-xfs/20220118232547.GD59729@dread.disaster.area/

And judging from the relevant emails, the main reason why ->get_link() is set
to NULL should be the lack of synchronize_rcu() before xfs_reinit_inode() when
the inode is chosen to be reused.

However, perhaps due to performance reasons, this solution has not been merged
for a long time. How is it now? 

Maybe I am missing something in the threads of mail?

Thank you very much. :)
Jinliang Zheng

> 
> That said, we have exactly zero evidence that this is actually a
> problem in production systems. We did get systems tripping over the
> symlink issue, but there's no evidence that the
> unlink->close->open(O_CREAT) issues are manifesting in the wild and
> hence there hasn't been any particular urgency to address it.
> 
> > Are there any recommended workarounds until an elegant and efficient solution
> > can be proposed? After all, causing a crash is extremely unacceptable in a
> > production environment.
> 
> What crashes are you seeing in your production environment?
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

