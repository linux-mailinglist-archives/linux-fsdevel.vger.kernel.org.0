Return-Path: <linux-fsdevel+bounces-18859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAAB8BD4F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85274B222EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC46158DBB;
	Mon,  6 May 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1MXKmWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5429158DA4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021702; cv=none; b=tEhB9ftfQI/OVXErjConlMjDizseeAQzx6EdJ/73UVwuvkqozbMlg6AsjMjZEtyQUl6koIOVCeqVnz85LyM/b7rCunf2bUSa8Y0tMjfYiow0iffNhHK/OgVy0MTSRb5qyPh//5ThDC2qYJiumFl0KVLn47ynEa2QDT9Gh4l6EiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021702; c=relaxed/simple;
	bh=Oo8EpziDrxcLobHCtvbnwPwMgHqSK4TTFan/j6GvaSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruYgCZXRq89vhsSrLuFT+cN16trRPlNSk3nRRLYhDtjdjus2D/4jLFXQUSGtbcrwt0o69mCngcpIkLzmtKqIYP4JJC3Org6Uuvxn301wtD3BlIXSKY0VXjwUaG9JpUjbTc+Re5dSSRs0XCCSDlhoJ+v2ZB5KLpx+uSDEwtM0XC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1MXKmWz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715021699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwhU9UCM3mihj6snjqM0qfSKdJf4MSL4J08BVU/a85s=;
	b=e1MXKmWzGUoUKOcfgs2NnuHrltajEBREoY3VTOx+J5xXzDZPSE/FYf4p9N6kIxxtAacRxZ
	PQYs/G/+6eOimg/T54WHgF6a3bZNObNv/HTM1xyHlkRS4z1n+4RiPnI/y+FgyidWPhi1u8
	o0X8laizohcIeW0ewpN+P03om0y0Y8A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-zZCHuBF7OuG4v1sFh5LrsA-1; Mon,
 06 May 2024 14:54:58 -0400
X-MC-Unique: zZCHuBF7OuG4v1sFh5LrsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42E7B3C108C5
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 18:54:58 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.146])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D0661C060D1;
	Mon,  6 May 2024 18:54:57 +0000 (UTC)
Date: Mon, 6 May 2024 14:57:18 -0400
From: Brian Foster <bfoster@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	vgoyal@redhat.com
Subject: Re: [PATCH] virtiofs: include a newline in sysfs tag
Message-ID: <ZjkoDqhIti--j1F5@bfoster>
References: <20240425104400.30222-1-bfoster@redhat.com>
 <20240430173431.GA390186@fedora.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430173431.GA390186@fedora.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Tue, Apr 30, 2024 at 01:34:31PM -0400, Stefan Hajnoczi wrote:
> On Thu, Apr 25, 2024 at 06:44:00AM -0400, Brian Foster wrote:
> > The internal tag string doesn't contain a newline. Append one when
> > emitting the tag via sysfs.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > Hi all,
> > 
> > I just noticed this and it seemed a little odd to me compared to typical
> > sysfs output, but maybe it was intentional..? Easy enough to send a
> > patch either way.. thoughts?
> 
> Hi Brian,
> Orthogonal to the newline issue, sysfs_emit(buf, "%s", fs->tag) is
> needed to prevent format string injection. Please mention this in the
> commit description. I'm afraid I introduced that bug, sorry!
> 

Hi Stefan,

Ah, thanks. That hadn't crossed my mind.

> Regarding newline, I'm concerned that adding a newline might break
> existing programs. Unless there is a concrete need to have the newline,
> I would keep things as they are.
> 

Not sure I follow the concern.. wasn't this interface just added? Did
you have certain userspace tools in mind?

FWIW, my reason for posting this was that the first thing I did to try
out this functionality was basically a 'cat /sys/fs/virtiofs/*/tag' to
see what fs' were attached to my vm, and then I got a single line
concatenation of every virtiofs tag and found that pretty annoying. ;)

I don't know that is a concrete need for the newline, but I still find
the current behavior kind of odd. That said, I'll defer to you guys if
you'd prefer to leave it alone. I just posted a v2 for the format
specifier thing as above and you can decide which patch to take or not..

Brian

> Stefan
> 
> > 
> > Brian
> > 
> >  fs/fuse/virtio_fs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 322af827a232..bb3e941b9503 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -170,7 +170,7 @@ static ssize_t tag_show(struct kobject *kobj,
> >  {
> >  	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
> >  
> > -	return sysfs_emit(buf, fs->tag);
> > +	return sysfs_emit(buf, "%s\n", fs->tag);
> >  }
> >  
> >  static struct kobj_attribute virtio_fs_tag_attr = __ATTR_RO(tag);
> > -- 
> > 2.44.0
> > 



