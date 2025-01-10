Return-Path: <linux-fsdevel+bounces-38890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED677A097C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3242D3A3C3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A0213242;
	Fri, 10 Jan 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FMqALCww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E3210F6D;
	Fri, 10 Jan 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527601; cv=none; b=moMI2wdZlsH84tOEg8DXryDpiHmyXEJokaM5do5vueypOzLoE5bWJPR0Gk2bblqdOlEKIh0x6Mgxf2ZoDy2MIfK78uF9d/+O363eu7rxpgA2H9XsbBl/4DDMryqnRmkEjFcPn9vZdXTDoSr8UWTDUeq+55wR9Yr9N1c9EV9PPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527601; c=relaxed/simple;
	bh=mC5WEjxjPlLXt5NGRY3gU1gtoiQoz2WChcIzJzjdeyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDgn2jA8mI5dmcBkaryOYNrDPZFUZ9B6J11kxQvtRbSWi8S+1axdaaT98mBsq0MpcnCQ1vreU25uQWXQbZG+UY11gTfN13k93/muq44UJ82kEnNppKF9BjLYoK3QZZGVZj0njaX0ZsXUoAt1rS8NplaOzxIZn4Dnl28xUkrYdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FMqALCww; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rnj4JwveGd20pP/SVmf5TX/F7gZngqQd8a1sgs58r+4=; b=FMqALCwwol1roK740NnBmzrcnL
	4gFg69KwcHsB+FWlWL7QKc4z2xrtEYdEi47FV0O9ZgZlXbYl0Yz5Yfdubmk2coWKEZqkQjJwmv1ba
	mmC+vHVmuVknDV/DW0YYM6MGKYqiEwZkMv8JBGB4XKzDRtBbHryx1pjmXLfZa9Svuc7GVKWP/rm3I
	hKuJrAj0phbBKUpRo2dhh01O4upJX5vFDEUQas0jfOJ/ECAD5y3nKCIuKz8XZTFvMe6wKMECtXXCY
	SKGC0WX4xZasMv3VIijmeyETlVL0Mnolwy/7FOxjpV6bK8R9UcaYdzfBAZM6q0GrfLptmeZPaCaUF
	K8MIWx8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWI9c-000000002zj-2HAk;
	Fri, 10 Jan 2025 16:46:36 +0000
Date: Fri, 10 Jan 2025 16:46:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com,
	brauner@kernel.org, ceph-devel@vger.kernel.org, hubcap@omnibond.com,
	jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org,
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH 04/20] dissolve external_name.u into separate members
Message-ID: <20250110164636.GW1977892@ZenIV>
References: <20250110024303.4157645-4-viro@zeniv.linux.org.uk>
 <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <1479433.1736494451@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479433.1736494451@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 10, 2025 at 07:34:11AM +0000, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> >  struct external_name {
> > -	struct {
> > -		atomic_t count;		// ->count and ->head can't be combined
> > -		struct rcu_head head;	// see take_dentry_name_snapshot()
> > -	} u;
> > +	atomic_t count;		// ->count and ->head can't be combined
> > +	struct rcu_head head;	// see take_dentry_name_snapshot()
> >  	unsigned char name[];
> >  };
> 
> This gets you a 4-byte hole between count and head on a 64-bit system.  Did
> you want to flip the order of count and head?

Umm...  Could do, but that probably wouldn't be that much of a win - we use
those for names >= 40 characters long, and currently the size is 25 + len
bytes.  And it's kmalloc'ed, so anything in range 40...71 goes into kmalloc-96.

Reordering those would have 40..43 land in kmalloc-64, leaving the rest as-is.
Might as well...

