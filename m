Return-Path: <linux-fsdevel+bounces-46441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A1A89703
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBB47A9CCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018B027F4F8;
	Tue, 15 Apr 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jW0Q6D0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864027C854
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706653; cv=none; b=Ydtx0EhbjdEUnAqt6bM1vEEvYwUg7fUmWjoNTJjfN8nqV5AR0ZTX66jqtUHqdHrHMmBpn+NXY0niSD6GpAx4Tx2dnY8BpMJBQGgdCJ6MQElnISC2LAZBN3kEZvvsPlPpt7qZyBPzCaq5k2s8FzE3Wq2DmF8RwqG9z9cWmuzzmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706653; c=relaxed/simple;
	bh=LAabiM4TPF38kAYsZUo11m9Q82vur12kUTr0m2VKGtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPK7FXdgdfKcCkQXNTzAyogE7E9WE14SiygvHaCFb/8xi2B7AcFw/xIX3aUcefiI4K+4burVg6cT0AnDWCgzg2yNbINIbbRZvDbEVgcQaWw3o2YTFtoL8LeVwx34ypsCF0mjEnMEIZMK9N9wNHdcmBfgbvzDbUycxsytIQ84pyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jW0Q6D0E; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4769f3e19a9so32994521cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744706650; x=1745311450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAabiM4TPF38kAYsZUo11m9Q82vur12kUTr0m2VKGtw=;
        b=jW0Q6D0Eg4AoMqjgkUZsu+8SqGw1G5YjtUOJMJiMxaAlT0LhQ1adCWr9paRbXd500v
         p8T6p6VO6Fjn09M87mk08snZ1tz5Qj3NMXEvCBvDna1jWewvxm0tc5mRRHLULasT0k0x
         re5KaQ0wvj3aSzxle3adqeYXo7mLIKDTBXzME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744706650; x=1745311450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAabiM4TPF38kAYsZUo11m9Q82vur12kUTr0m2VKGtw=;
        b=Fqtl8RzH8+Bjx5ZZ0NwHhJ1FxhtATCJeqU2mhCy8Gk0xtV3uTMP9AA1urKlQVjHPx5
         TsmEeD4HACyFWy3Rv/ubGIkgni/Bz9a7VWaJH9vztXgscG+J2zMwjlEPxRIwQ+SpUiGb
         CLG+z9Ud0olsTZJjLvDC9cZYD/+FoELRdoZcW9M1CfBHLYaFo29p3PO7oyBEYq9/4yYn
         DrCCbe6V0ExM4IrXOSsQhC0VEH5Um/TC/CgjrP2toeLTr0Kdma8WvK1bpAH9HR49HlA7
         kHY26+/WKx7//k3QkND3xTpESvXNNkhsE2I7kJM0mVnaOguvXdCURrN5eEU/FN7hfU3u
         8zXw==
X-Forwarded-Encrypted: i=1; AJvYcCVXpJAvemX8QkuWt54S6wWxLvgudqq/EfdIKRd5NHzaIAu4gwPeUKbz6nIgXRYozbnS7uqTDG8o/JlDROk2@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlZ6B+L4nNOex1d3z3+uG1VJLwvLmPZn1PgiX9a/kk8WOhavT
	YxMcd1PDXLAlE3pV3sr2WYVxMQk2RKsTvNY64Olvk7iEPtAKamWEt1pRHIh98uaOGTSZbWdgCbo
	NuF5OYjhh5IRmd56MI6/PFz49o2DBzR9WZ+eNwQ==
X-Gm-Gg: ASbGncs++2BG82aNJM6gXB+oilpQGkczXHEmtKEe7YL8otuCrr+V9jAccJIquIp+t/t
	ch2N3TZUBO6//zlAh30WgKW68+ltpAT9npCEejg49Mg/1KllIqsOZliBsbiUQzXl7pNu43zxzOm
	xzDhIEO7O/dks0LWfhD6jz
X-Google-Smtp-Source: AGHT+IH2zkg3JBkVX8tZSe6Dymy425acHm0nx+g6+ODx4iVkOFOHuLBjkcilgsmZjJf2lWdAxiR3JKelikOF23YKSRA=
X-Received: by 2002:ac8:5f91:0:b0:476:83d6:75ed with SMTP id
 d75a77b69052e-479775dd23dmr277687171cf.34.1744706649975; Tue, 15 Apr 2025
 01:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com> <20250129181756.44C9597C@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181756.44C9597C@davehans-spike.ostc.intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Apr 2025 10:43:59 +0200
X-Gm-Features: ATxdqUEXb169NCqOpyB29RP_KpKB9sap8dRPbGCysm9RqLIzdCcscH0aFeS-Ig4
Message-ID: <CAJfpegtc56iCZe7KfEm-juA7DriLn7Pe5yvZEWzZqx1R5MdicA@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: Move prefaulting out of hot write path
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, "Ted Ts'o" <tytso@mit.edu>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 19:17, Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Prefaulting the write source buffer incurs an extra userspace access
> in the common fast path. Make fuse_fill_write_pages() consistent with
> generic_perform_write(): only touch userspace an extra time when
> copy_folio_from_iter_atomic() has failed to make progress.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>

Applied, thanks.

Miklos

