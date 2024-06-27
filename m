Return-Path: <linux-fsdevel+bounces-22688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9961191B0AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADA81C22652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA419EEB9;
	Thu, 27 Jun 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UVIIzkIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74819538D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520883; cv=none; b=l1SXek0qaGPiIxcz2ubLDynzLQjsNaW4ucpV1kPrKbfk0/eQ2QJnzWly1IV0aw7wVkNN3VQ4XnziBpfGUBmYo53HJaoTfN/OVm/om8Sm9Plf1as/T1cxLqFAnvB4wdnWaQsOvCxM7xvwbDb7zgwD3W1Wl0zVFSMoJbf4N+G8sQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520883; c=relaxed/simple;
	bh=6c4jsOigt9Ruk43a9HCcueSY0YeUSMFClS0eq+S9m88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjrah9Stp+1z7iRLLVQdlIF8ewuFFAYsKxpbft44ENA+j2lcjYMgx3Ftpa7eVw3L32ybTQesgRnXQeis9eOsPCXaYxIcK+vcRDN1447hawD5xYGzq3s8U5LF0TXhu29GBuBY35jF5cDZ/nugwzPf/FsklMqL3AvbQ2DEls9dTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UVIIzkIV; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-446416dccd5so5824971cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1719520878; x=1720125678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yo7oSl8s5fW3RzTF5jL4BNIokFeXY+7HGhql3Vku1kY=;
        b=UVIIzkIVmMkkgsoPEYsRsVrnq2LF3tRCwYZPDLOgbeT2EFVpOUyoKtbtxPNus4B/S+
         ELhTQYL9QCOKg67OC3oBDlJu8LmIUj8uqc4ORem2/NW62bwulasAlUlkCtO/Z7S2+oIE
         3YR3nOIEDgNDyhJWnWlHrDOOYn8Sn21nocnNW0M47DvtvYdF+ragBHNYgabnfXra8KyR
         vhviPyOjub8zuLxUClEqS5MdvTgFM4mSNXo+dkg3Z3pYydCFWQoiavf7lEVJpP00lwG3
         ZU3Kr2MGg2Vi5rEpN8L3YPfbIcIuqZf7zJqLDdWoro9N8Nfmo6vxN0UcUB0tsDw0koCg
         pF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520878; x=1720125678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo7oSl8s5fW3RzTF5jL4BNIokFeXY+7HGhql3Vku1kY=;
        b=N9y0RcVt6tJ4yeFUU+iXWAp0arl1Y8OEdVEMFK5/yVyZAeGFHo5y+0PJK0DCQP/OhH
         rpAHb9/lUiBrXCOGCFPAHi8KahsTTPSVKoDOxSPcVOL7TWEipdB5D7y+vqUcjVu8pQxx
         mRWRZm9qr6l28L395U1Mx8C9rGzbHQ1Yf7wahpJGnttHdbSg+q/qYCuUufnSpEPXhfs5
         IifUnQcU39UJ6pub03faTOBC2i2CfmVyc353IM7oBYozP+SXcQVNVeIKZa4qekPqxjlx
         qr91TQF28r4B4y+AlEVYieoK5Lke6u1+klwebxQihl0hIwpWOHV+iMek/9Kb1+Vw18Dl
         h4hg==
X-Forwarded-Encrypted: i=1; AJvYcCWC8M1YJ5BM3LNbxt9RG9tqV+cswAlgghfx0ZviDZ7N2dXEmF9imZRtnrl9HuNsfsohGpjncDx/8LXqKHofpDhuK48JtOxUSE3zEkMJzQ==
X-Gm-Message-State: AOJu0YzAcvnrWBNOrnKByiguAHQ2QqpPbRS+czoq3cCZUpy94zeRgJAK
	EVF9mLDvDElN95/6oO1pN14YHV+xxvz5m7eCkqkEPsyyKzsHZMXmqiAxibTn7io=
X-Google-Smtp-Source: AGHT+IGFIa4hRaQA4Mu+AfyzyAeM600yB3mVaPeVNWkc2nyBTtruDGKIVTjDcc3JK0L5TEEZ2mr0/g==
X-Received: by 2002:ac8:5a4b:0:b0:446:426b:70f9 with SMTP id d75a77b69052e-446426b7a4bmr31951631cf.24.1719520878558;
        Thu, 27 Jun 2024 13:41:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651498827sm1607971cf.62.2024.06.27.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:41:18 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:41:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
	ying.huang@intel.com, viro@zeniv.linux.org.uk, kasong@tencent.com,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cachestat: do not flush stats in recency check
Message-ID: <20240627204116.GD469122@cmpxchg.org>
References: <000000000000f71227061bdf97e0@google.com>
 <20240627201737.3506959-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627201737.3506959-1-nphamcs@gmail.com>

On Thu, Jun 27, 2024 at 01:17:37PM -0700, Nhat Pham wrote:
> syzbot detects that cachestat() is flushing stats, which can sleep, in
> its RCU read section (see [1]). This is done in the
> workingset_test_recent() step (which checks if the folio's eviction is
> recent).
> 
> Move the stat flushing step to before the RCU read section of cachestat,
> and skip stat flushing during the recency check.
> 
> [1]: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/
> 
> Reported-by: syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/cgroups/000000000000f71227061bdf97e0@google.com/
> Debugged-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Fixes: b00684722262 ("mm: workingset: move the stats flush into workingset_test_recent()")
> Cc: stable@vger.kernel.org # v6.8+

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

