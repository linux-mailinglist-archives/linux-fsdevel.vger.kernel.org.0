Return-Path: <linux-fsdevel+bounces-10665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59E84D2DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13761C24B06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77718127B70;
	Wed,  7 Feb 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="k4xrhElc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C0127B5C
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337409; cv=none; b=m+dZNKXxng4cs0/cIzhSqfM+qPsKlGHr4/IsksZrZ0mTjczanDodmwxY7I5JsbMM0Ju7tPULXKbiXOINsTkSQibuNVDK1gukxzfv3I5yWK7iq0kvHrhbcMNoLMcP0uiyyjJ/CKxlepQuQPY8JuBXdZr06sIkhhhXsQVM+YxzmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337409; c=relaxed/simple;
	bh=52gKcX+UmVuwAMUKbS3chE8siFn6XrLd+UQ4CKtpUJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmI7dRdX3iifEMUAy8WOV53JgGmZx7U4wTuB7jf2J+MUrfMnnQWEn0D7q4Ibc35p1Dddt0uqMVIgZfaAv6YRQNbZGmMcSEXVOvs+ZNJ9tQAYw4sck4sK3LLZfNKX8a7qUv9uQaXr5lwdhCxJJwQze5QIjSopu3OSn/e8+e46pWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=k4xrhElc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e04ea51984so602748b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707337407; x=1707942207; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUv7lvVM6VkpceK/tQ/gnRd5CGoChU/5Uxt3s4/vCy0=;
        b=k4xrhElcjgnpwa5nBq+3uihGvCEv71F1cbBkJpr8cbJnbMbU8X2GhBWg6+ebz5FU31
         m8RzIgDggcwWxzcNWpO1Qv0Az28VVfuPR1mhCtwRovxx/wTMCctDgKMLX94OKGHX+A48
         XVN1TdsRZmbTH8Jx4QeLsZYAOILAvQaaCLeAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337407; x=1707942207;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUv7lvVM6VkpceK/tQ/gnRd5CGoChU/5Uxt3s4/vCy0=;
        b=RiO31ZatWq7jjUZJiDLZRM8Gg5t8Q/8GkMxRNWr4g1RiMyIUlwKbvp/a37ecEgqA1U
         0YiCJf6ffTlk2HvMIFdoxAmzVJXre6U+lAqP4kCqR29qvrZYGgQf6mi61GFVtLbcBOje
         vtpGRsoL+7F9s2yJR5a6mkghhMwesusA9QHkV7xdIgUW/Hp8lTT+xTF4oPWpUp11OBCt
         GdZKtVUh8lxCq5vlZ+1nBH4R/3xcpcrB0vHS5lOBqJtCDDk9YA030B6FhsfVNpvu8Uxx
         /Womq+YcnTZhgQCL5XeIWac6HjA27OXzLdeE14325BE0VO+ptWyIdsD6rLYu0ChMSzip
         tEJw==
X-Gm-Message-State: AOJu0Yzq3m68wXIz+uswIrVbB8ZqIB6It5FAdCrq+auwtOpMzA50R9xC
	IWfbRUf0P8UkqAq9WJiY/f2p1Tu5uwIxAUzrdTIYoEaMq3jGZFs8A0P+9srD7Vk=
X-Google-Smtp-Source: AGHT+IEqzeS299vkOadTe30zptDF57rACEt8HtEWFtpkIBhx8ucnYYZK4I3R+U+qqJwKLVgcRhOAZw==
X-Received: by 2002:a05:6a00:418f:b0:6e0:5ebe:89f1 with SMTP id ca15-20020a056a00418f00b006e05ebe89f1mr5023588pfb.13.1707337407486;
        Wed, 07 Feb 2024 12:23:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCqUE1ygMi5QRm+bprEdVdWJwdWoU7OckQ7HYlQsSwxfrRQ0w1+Q0hpe0/+qzeRc/q+6TlwYqyhmoi4bEJEJAlnHlFDdWGggJFPayc3yYYqjVKrqu62dWm6HcYGrTnk0y5pr1QN42ubb2OzUcBklB5HhZEvkvtPGRKMaxzkDRxJGoEgnTwPOH7rkEGKgU9wLZAqdDHUldk8x+o5bDcTFvl3RA/wwaUfQna0EyzJ1oFge3JzOolnxycEx/8yypvjMXKlz8hXK9+vXwCY8uXzTmJg7yxBskkHf+rslkVZeCJG/xK0d7xowOx5MgOHK5snYF5YwQuxLCB6/FqktgX93hCk7k070E9ePSO9MnXEvOd2tc0rpMB/a2O5pepImHDhG98WmBdRBSedlHuX/80/MAW4FKVpQ9ov3MboTl9SFJr8ftv9rs89G0Di+LaoNaO8FgvcRci4srlT7gzzyfMtv6PU22/C1tpIcqnozgVaYkexZmdM7I0OqPu+7BCJggqnf54LtX/g+g8MKl8hJT3+piYHRj6emQu65mTCirCQdJZo/Ewpm47/9xtFPw9iMOzPfuZTT8b89ARKX48K0G9mQ77QUlamjrDBSuilDsrb9jAMw==
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id cl13-20020a056a02098d00b005d34cf68664sm1874233pgb.25.2024.02.07.12.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 12:23:27 -0800 (PST)
Date: Wed, 7 Feb 2024 12:23:23 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	weiwan@google.com, David.Laight@ACULAB.COM, arnd@arndb.de,
	sdf@google.com, amritha.nambiar@intel.com,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240207202323.GA1283@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
 <20240205210453.11301-2-jdamato@fastly.com>
 <20240207110413.0cfedc37@kernel.org>
 <20240207191407.GA1313@fastly.com>
 <20240207121124.12941ed9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207121124.12941ed9@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 07, 2024 at 12:11:24PM -0800, Jakub Kicinski wrote:
> On Wed, 7 Feb 2024 11:14:08 -0800 Joe Damato wrote:
> > > Why do we need u64 for usecs? I think u16 would do, and u32 would give
> > > a very solid "engineering margin". If it was discussed in previous
> > > versions I think it's worth explaining in the commit message.  
> > 
> > In patch 4/4 the value is limited to U32_MAX, but if you prefer I use a u32
> > here instead, I can make that change.
> 
> Unless you have a clear reason not to, I think using u32 would be more
> natural? If my head math is right the range for u32 is 4096 sec,
> slightly over an hour? I'd use u32 and limit it to S32_MAX.

OK, that seems fine. Sorry for the noob question, but since that represents
a fucntional change to patch 4/4, I believe I would need to drop Jiri's
Reviewed-by, is that right?

