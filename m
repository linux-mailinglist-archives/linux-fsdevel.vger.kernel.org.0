Return-Path: <linux-fsdevel+bounces-46591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3ACA90D66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C8C17B19B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F46A207E0C;
	Wed, 16 Apr 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="smWTF4hL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82B204C18
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744836658; cv=none; b=rAW3XoVoTuampmuTiREpHHW26TmEeorjTsZAdZF6bzxkaeqj+jytKt9etIgZzb4kY5VkCq5C9u2a27KegYq9dQ1nFsgD67/G6ONAAynicFjDGfTdEQF5mxcj27R+LeU4Lxdew+IwXWbXFIsBspbDMahm5abP4jx9jaiGbKAiOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744836658; c=relaxed/simple;
	bh=9X+ldxpwI7mjM8BAndD6bOzVG7msqIT95VP7hnNoqfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J41P1G7cT93nOtb1ycPd+k13rAsTUlDjCcVBScVZA52UxADGi/Dx1EEYNBMOyB0SZCW770y6Sboj+lrZyHFI6wilBnHWPKs3tmXdplNhu012+LrD7cOMThSD7cn3qhc77rx/mTH49weKkoi1ckclq7mVJBGmjieGaTjHkRWud1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=smWTF4hL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fd89d036so1333565ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744836655; x=1745441455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMssVsRnucpQR7VUysa3FpPRBu9OqCGpRWchPdGUx/E=;
        b=smWTF4hLhaJSC4WuXpAlEOYEq5ECrXrhDBJD/Qs2a5Mre7kQtfx7v+7C0TXurj0thX
         vYIlQTp4t9iPBtLGn1Pb853+hj42NtlJJyEE7CvJhI7awJHA6/u0DfHUG85K6ZNVxdQJ
         lXCb+mdLEksAOlSOWvYvkNzOk6cXPoQL1wwKlze//BMPJAEsZz6dzrFS6JwjkWl2sISb
         hEgT8uNBzVhA6CRNsu+DcWorOE1btNg22WTZ02BNFoYnjt9Z5kPBX0pOLAJdqCzHkMww
         5Z7ULdyC6Y5NdHwPXO//dGKvkm4W/r3Rbq8YfPJZyDQs6y3bjCaNxIulLxd3ah2fuMWj
         e8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744836655; x=1745441455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMssVsRnucpQR7VUysa3FpPRBu9OqCGpRWchPdGUx/E=;
        b=ZxHS6YYGvHwf7cH/Trl0WOzUj93DEZNRg3hJNfzcxo5tsL7fn4dbMjh+0i5YmUWNsQ
         NfB7TfGciMkN0dfkVJ0gafXHdUcv6GvinSo6OJq0uAItJfPYXxX1AFOGrIs04+yL5T1C
         bCkHI+ipEUbk8dWL/cp5+bvvXZmlsVJJ0bs+dyz0CBRXwtV4hujkA/LXP8QEIzf2e/7Z
         XExWPbJvaWdkc2GhikVBex86xxUio5GRud16O4a5StXHz2+Wt325ZWoKWRrTyJ6mKQjI
         HpaWgIhBY5ezJ4s5vBcnHYfxaukOkdkdAe++8SzNmAtOh832w42EH4zoyLXkFSg8Qa9J
         T9vw==
X-Gm-Message-State: AOJu0Yy4MNln1KRJ8ioERNLCgQZujFoBpXvnXJ6UINUQ8WsRLSdeV1zJ
	m5ibliuC69AMtoaMJ9MKso/bUY68tsrMHePvav3n3uFjmSidFof4MbhyUTNcSfY=
X-Gm-Gg: ASbGncuUxUtC5m0YZyaOGLtEvO1y0som69URWGD3DiiosyycXehtsFs70HjfbgjdQMM
	CHW+sRJribyMARVBD4QTji/it3zStAgMq30mBSq01gbBVzOD1xrW96Pr8ssz8MvwALSYsxVrw73
	Y45YP9KVEV/LbMNxNaTiJQ0AsdmT9nhby5MJ9+8E2Ie1oHpBiEXCctp5u232mXMQ3JM0EB4vdcB
	x7ZmNCdpt6v38AmcYMLOvWTtPwoTE6B+FXnmpecOcQ8GHPTf0sJGk0qBXk4muDhopfA3PwDAVDO
	7Mc1dI3BYQ/lXHYOyyRpV8NEq4rgSWaIxi9VFP8pL17WqXx3PUUjZKRzshGH75rr0zv/4KQ/zAS
	b7WkAJ8BHY6u0YA==
X-Google-Smtp-Source: AGHT+IF3X6K0MFFrPrPyEm58xxYMkajjc1zUqexHWNgAA9RKIHUkR3Ti4TiOtnd2jRtincY0dE70Jw==
X-Received: by 2002:a17:902:dac6:b0:223:628c:199 with SMTP id d9443c01a7336-22c359ac500mr52649475ad.52.1744836654870;
        Wed, 16 Apr 2025 13:50:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fac055sm18893805ad.107.2025.04.16.13.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 13:50:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u59id-00000009RUm-21Bm;
	Thu, 17 Apr 2025 06:50:51 +1000
Date: Thu, 17 Apr 2025 06:50:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [6.15-rc2 regression] xfs: null pointer in the dax fault code
Message-ID: <aAAYK_Fl2U5CJBGB@dread.disaster.area>
References: <20250416174358.GM25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416174358.GM25675@frogsfrogsfrogs>

On Wed, Apr 16, 2025 at 10:43:58AM -0700, Darrick J. Wong wrote:
> Hi folks,
> 
> After upgrading to 6.15-rc2, I see the following crash in (I think?) the
> DAX code on xfs/593 (which is a fairly boring fsck test).
> 
> MKFS_OPTIONS=" -m metadir=1,autofsck=1,uquota,gquota,pquota, -d daxinherit=1,"
> MOUNT_OPTIONS=""
> 
> Any ideas?  Does this stack trace ring a bell for anyone?

That looks like the stack trace in this patch posted to -fsdevel a
week ago:

https://lore.kernel.org/linux-fsdevel/20250410091020.119116-1-david@redhat.com/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

