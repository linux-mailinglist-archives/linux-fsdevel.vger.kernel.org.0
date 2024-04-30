Return-Path: <linux-fsdevel+bounces-18324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C98B76F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FBAB20A08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0917167B;
	Tue, 30 Apr 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKgN3mp1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FF17109E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483563; cv=none; b=mi7BZJcj+57lw+t1WcYmouzMSR8+BW2Dw1RDiqgAwmPSuF5BBS40p6yq6gx6zKvguKo6oE0JbfqMcWL1F6nz/PzKjXQvUOVNB5Q5A4RJuhuX51WBjfAr06NJb3rlwZ3N8eMfuDTDYHbSTdjZ3FssrYcOfzJ5/9XwgFvrQRhCez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483563; c=relaxed/simple;
	bh=qxKHc+3IjdtgWPSzmFTsm4Rp1Qe+Rn+ZDTiZ1WfOFko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhiXCh3vad3Azb1sP4wLcUCa+t7xkQA/7zkF+87IwHA0EEsKFzpj9KZ4PGgbF4THU6GkXRDqjHSIHutGAI/YSwcpAUV8Mfh+KHnX7qe/GFPtt2JQ+yBtW1XCazs8eSlgs6iyaRoI32mZzHWog4TWeVLT2EzPdi1xj0vD/Z3l9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKgN3mp1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714483561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5bYB5V2IJRmUQ43j0ThALYY+p/bSkCZh56Wtp2ChfRM=;
	b=TKgN3mp1nzxKiW0+mFPO9QhGqOgUwphUI1rXXRztjq/3yiScgCF7wxwosLythA8IPgkI6H
	0LE65GEvOFQl8LxsVV+UfYI2zOEsvSnjMMZlGM9qHeEtIespjPvHGbS929riUjbcEtTJaR
	GgpcNhGafX1kWceksv0m5GIOMVQqd6o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-lTWCjtPLNw2NiTrsyNl4xQ-1; Tue, 30 Apr 2024 09:25:59 -0400
X-MC-Unique: lTWCjtPLNw2NiTrsyNl4xQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ec263943d0so9299345ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 06:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714483558; x=1715088358;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bYB5V2IJRmUQ43j0ThALYY+p/bSkCZh56Wtp2ChfRM=;
        b=EfrzbUbYhBzLc+ecZ2nwyKmo0BWnm7nYjTuwim+chdkORT40AyHZCezh6gqyr1cjKo
         xwLYaKsgDC5jtXb5UDXfbSYmpTS2IYCUht3wjB8nEAo+RBIdTgSgiEAP+ePta0dTTrUb
         YTT6HsTYliA8O4729A8fZVjsC8LwRSuFEdh+q8Dfn4w2eBO9Ik/7ji9JKMwiBvtVEGV8
         Ca253WSqiRJv3iTdGnwptYXapRXC8xqZz0wi7uigVlYuOggJoNddDSy9hmJ0ccKxlkGV
         HF7Zj2eJcR4n2bVvCQBaPg6iXG2KHMwem2evl07iFG486urCIdbs6YW8pTRZ3If0IgQp
         sP3A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5uzJsNqvl13b+DtTVDO2xBfRu7vOP0c6Nda8YFCu9R4g6Joei3tQTtNpYMNSF0p4uxH0KeX4OXDeYp/kk+tuNDVPHqCc+7k0ESbhOw==
X-Gm-Message-State: AOJu0Ywim4AzzozQqefaMGHB9PNCOSUN/RLxiAWfiwg0cdFFNX9d+wQF
	pRCtMJ68au/4SW7Cz6Gv9YeW6I93amPmuaZL62dMaL1RvFwywKcf2ByL0Y0V4qK8w3Uz9c2Ipvn
	vVTi7OxerIHl1+GSID7YgDScPfzWgx3cNEcMeBXhqMeGufgUXK2qrzQRD7+Pqt/Q=
X-Received: by 2002:a17:902:f550:b0:1eb:b50e:3577 with SMTP id h16-20020a170902f55000b001ebb50e3577mr10570420plf.56.1714483558646;
        Tue, 30 Apr 2024 06:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxs4AWBUfB1yS81UFM8h1aOfhXtPbsohVjWorZOtXKS8eQlwPvSE0k3WOK36lgTTVuZX0QVw==
X-Received: by 2002:a17:902:f550:b0:1eb:b50e:3577 with SMTP id h16-20020a170902f55000b001ebb50e3577mr10570389plf.56.1714483558318;
        Tue, 30 Apr 2024 06:25:58 -0700 (PDT)
Received: from fedora ([142.189.203.61])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001ebd7ef383fsm3846580plg.203.2024.04.30.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:25:57 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:25:55 -0400
From: Lucas Karpinski <lkarpins@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexl@redhat.com, echanude@redhat.com, ikent@redhat.com, 
	ahalaney@redhat.com
Subject: Re: [RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <6rp73lih7g2b7i5rhsztwc66quq6fi3mesel52uavvt7uhfzlf@6rytjc7gb2tj>
References: <20240426195429.28547-1-lkarpins@redhat.com>
 <20240426195429.28547-2-lkarpins@redhat.com>
 <20240426200941.GP2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426200941.GP2118490@ZenIV>
User-Agent: NeoMutt/20240201

On Fri, Apr 26, 2024 at 09:09:41PM +0100, Al Viro wrote:
> > +		call_rcu(&drelease->rcu, delayed_mount_release);
> 
> ... which is a bad idea, since call_rcu() callbacks are run
> from interrupt context.  Which makes blocking in them a problem.
>

Thanks for the quick review.

Documentation/RCU/checklist.rst suggests switching to queue_rcu_work()
function in scenarios where the callback function can block. This seems
like it would fix the issue you found, while still providing similar
performance improvements.

workqueue:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.003066 +- 0.000307 seconds time elapsed  ( +- 10.02% )

callrcu:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.0030812 +- 0.0000524 seconds time elapsed  ( +-  1.70% )

Regards,
Lucas
 


