Return-Path: <linux-fsdevel+bounces-54577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE8B010AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 03:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C9D5A0ACE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F67E0E4;
	Fri, 11 Jul 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLGbzQgj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7B746E;
	Fri, 11 Jul 2025 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196732; cv=none; b=KJkxRB0QPGP03YUk4tTm5YcUFqazglYFqP4gxWDZ0NUTEibAZF6qTn2nPZowTinxyUlLKpd17jJxGLjDqzaOXAZSVKg2dx/DAPwX7EhQqllOB1DIRlbBYl3e7nW17s6o5YV1rjxkVSKrZM7/i3OzkgXb5vuqTGdPOtwQeNiZcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196732; c=relaxed/simple;
	bh=R8AABabAlWYs5sROsKxYgIr8UcUVRhflbLr2PL7WTUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCR2DDJkDBlcKGFLeGKRvhpAmVWuGzDWvZmWMKlfbXx6M83yW2xTYjx6w1+aH7yEbv1foQaD3ZQ2MMfUnNMJPw/UxkqqKTpLetSJZNT0g8McRx9JGG11//aosvgGcgx+uR3F0ijdhg1xXLuUHp8fX/o/UP8sonzYVRLf/tMlkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLGbzQgj; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-611e20dd2ffso526834eaf.2;
        Thu, 10 Jul 2025 18:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752196730; x=1752801530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g0KFXDxtk/APA3qVySJRW2x29mZCIrc20VuPGvJudw=;
        b=NLGbzQgj+NmTc55XOejmp+5lX3sI0mSh+dKlRVf/Z8ZPU8foxVFFOoiBbUV/6rJSPu
         K/VwmK2HevBQvt+SYkB2ESFfj61jxfCk1K1ph+6sIebRMYAXQaXHj95R1hQW6iKf0xOh
         XvshEAx+7wiIQC4szwbYHyROS3rOo2wA6feKZXTH6bqUjXwFOoVOpwOy0UUx7cIiEMfi
         UBuW+pI5I8vd4sKbYQcJMzjkSkny8G0XFFaC8rCyq/Ki/Eq/X6w9dY9GspWFRkny9Qoe
         wZzONqbUTjcivs3m4RW5yJdVeK9gA3R3nX6PnuRnbYYUZiraN9ho19fgoGm4jC3pPMQ+
         cDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752196730; x=1752801530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2g0KFXDxtk/APA3qVySJRW2x29mZCIrc20VuPGvJudw=;
        b=BzaWJCDf39eTLRdXL2LnuNFe674j0RK2RDaSMQjorUI+oqRt4y2hgy1WvqAwrGd8wk
         YtzJ1+pc9dvBhh/LJgLmaDBe9t5GREUkktyPoNdd78nIKhFtqbZXG4HRT1SraNjcE38e
         B2b3HMPUc6lJF4hb8f75aJ0Dm7co+QzYGB/1HeAVXVsgbCJT1kiQ4NeN1Lvx9XAOpyYO
         bwDup/MAA4c8YjozHCNJG7FxqdWzjN2yh2CsdUUo67k+fwCoeuVQVWWAz4FRSzWIjnyb
         dsGOyuT9bh50d8NFlHqePtGmQ6Io6wPxS/yU5uxTMcWsKYtZIiI3kUz0b/TvFfWA0XG6
         f31g==
X-Forwarded-Encrypted: i=1; AJvYcCVq6WIcQ3/jJC3iRocKtE8yOsNHnMlyLvD3JGGfn03QsDnNToZlmZWAmbN4zSJ7vQ+X4Ph5F0xTxuvU@vger.kernel.org, AJvYcCWLa0ENFY78XvLGqwYAnHSMBAhenS/gBN7l7aOIuty7vdEpy1HJmIolBdVD8bZtEdGobL1T+a2v9bAYSEB2yw==@vger.kernel.org, AJvYcCWecTC33XPCZfiERaqRyrVKOzb9pfICgrSbmnvNXBYWAcBnMFeldqviO3WrQ0R06tuWmP1biHtyc5X1GHJM@vger.kernel.org, AJvYcCXc8S8p/lWVN/C9ae6YBepjuo3umfbsjhunFlwqV662a8/rCffyh84ozMn6hKB2oNJHzp46dFQH21k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNefcEcmym96Rt5+O4vZJNC9VVr7aGDw681wCJivTl+7E07nKf
	/6zn8CcrU2nJb54RI2lQOHUaWBSvJvCwhgzlb87USoE96qVE8dEuI2qj
X-Gm-Gg: ASbGncuE/xOiGGxLJ3KVU2RbIGsLdpwX//9TwIe5pmS0oDJ4gxpPp2sG65OjLf1dFPO
	qN7HOa8W1PftSjqxGRke5nu6dX/FbIe484yzRjXGiENl/9MuCfdywxTc6sB9T6qDvIzx9ohftra
	hqOxk26tX082tRwMt0Y2lnx1pIazVQ9+0YF+bpsBo1NhRpeNSC6BC2fqi4KTFqISQug3ICZzFhC
	NGtVDCq7n4l1oobA7Dw1MZvZzZI1rfjmUxDrqK2AczwWbZwCLRTJA4ucWHG+fLyqnMODuaR4pB7
	J0TPS7GtKBN/FTze89XzqsuaYWjotuAc8eL+/rk9f85+b6pP9za//bRPrYvrafnIs8f6Zsfm2kt
	4arqj5O25Q+WDya8BC1h9RZqSkBw4S9BCI6iM
X-Google-Smtp-Source: AGHT+IGJCnaqGvb/J1NAhW1XcF8WESVSsXDnoLdvhZ4+00xo2gwgbnca4tl65tWGfO6KVztDNniiVg==
X-Received: by 2002:a05:6830:6c0d:b0:727:3957:8522 with SMTP id 46e09a7af769-73cf9f2c45emr1252973a34.20.1752196730333;
        Thu, 10 Jul 2025 18:18:50 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:25b0:db8a:a7d3:ffe1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf108af60sm396801a34.21.2025.07.10.18.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 18:18:49 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 10 Jul 2025 20:18:47 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 00/18] famfs: port into fuse
Message-ID: <qcro3gfcssyvto7rtqkykurb6uh5kqslse4zllosk6bukaualp@xmy6jchvm65p>
References: <20250703185032.46568-1-john@groves.net>
 <os4kk3dq6pyntqgcm4kmzb2tvzpywooim2qi5esvsyvn5mjkmt@zpzxxbzuw3lq>
 <CAJfpeguOAZ0np25+pv2P-AHPOepMn+ycQeMwiqnPs4e0kmWwuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguOAZ0np25+pv2P-AHPOepMn+ycQeMwiqnPs4e0kmWwuQ@mail.gmail.com>

On 25/07/09 05:26AM, Miklos Szeredi wrote:
> On Thu, 3 Jul 2025 at 20:56, John Groves <John@groves.net> wrote:
> >
> > DERP: I did it again; Miklos' email is wrong in this series.
> 
> linux-fsdevel also lands in my inbox, so I don't even notice.
> 
> I won't get to review this until August, sorry about that.
> 
> Thanks,
> Miklos

Thanks Miklos. I'll probably get one more update out to this series by
August. Best possible case, I will have fixed the poisoned page problem - 
but I haven't worked out what the fix is yet, so that's an aspiration.

Regards,
John


