Return-Path: <linux-fsdevel+bounces-24414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A10893F12B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07FD1F223E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AADE14372B;
	Mon, 29 Jul 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENmdq1hJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC30140E37
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245403; cv=none; b=fdy60wXii5/c4O9NQgo9GFU8A1Ppxr99xyJjDXtmvQYnLaNIsraAOU7Vs9NOy8XUjhyMtEWj1OLtKkSwKksTCguGg0mOAaNogCWcAZBHmASWcefYPx86ARqSuZWZSqHvkIIP7jdOsYTy+i9PWkFsQWwn7XxizuEB+l+o71LDS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245403; c=relaxed/simple;
	bh=u5RBreyVfXRXoOakitt/Ifw1gmojIQrfXV5ulIFhMQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BouKm2ke/lKatvk3xyKmVpk6GAyPU7fDs+VF4iPwq0z+TkVQkpvhZd9pRviT1KO3K70PhAtoMaAPWnWbCyI4pwLM+jVpfZJpKizq8rPEh1xTeutKPtDYBPv9z8V0xWk2/DzPaIJDecpqa4o+EtGQB/FxGNwCVf4zuFvo53jqAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENmdq1hJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722245400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZTAP+nDSgd5C9ys1nFKui+wNX+zNnEPNP6ru+kr8iY=;
	b=ENmdq1hJXyu69lQ1iDeAUzwfMD1YZxD69tKIGID7gfpAaUrs9h7Mfm/UzTkkZYOMfMrDFl
	zEgeiBak+tyD0rp4P2IUSjyf8T2RuqK/aZg72K5zROQh/gstEOgC2h7iL2cD+RS50MPwjx
	Gbl6HHmyGVkXv96JmBy7tMljBcZcWaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-4mD4iOlSM5qQFIZtJyOz1w-1; Mon,
 29 Jul 2024 05:29:56 -0400
X-MC-Unique: 4mD4iOlSM5qQFIZtJyOz1w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2B801955D44;
	Mon, 29 Jul 2024 09:29:54 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C8AE19560AE;
	Mon, 29 Jul 2024 09:29:52 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
In-Reply-To: <20240729.085339-ebony.subplot.isolated.pops-b8estyg9vB9Q@cyphar.com>
	(Aleksa Sarai's message of "Mon, 29 Jul 2024 19:09:56 +1000")
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
	<20240729.085339-ebony.subplot.isolated.pops-b8estyg9vB9Q@cyphar.com>
Date: Mon, 29 Jul 2024 11:29:49 +0200
Message-ID: <87a5i0r1f6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Aleksa Sarai:

> On 2024-07-29, Florian Weimer <fweimer@redhat.com> wrote:
>> It was pointed out to me that inode numbers on Linux are no longer
>> expected to be unique per file system, even for local file systems.
>> Applications sometimes need to check if two (open) files are the same.
>> For example, a program may want to use a temporary file if is invoked
>> with input and output files referring to the same file.
>
> Based on the discussions we had at LSF/MM, I believe the "correct" way
> now is to do
>
>   name_to_handle_at(fd, "", ..., AT_EMPTY_PATH|AT_HANDLE_FID)
>
> and then use the fhandle as the key to compare inodes. AT_HANDLE_FID is
> needed for filesystems that don't support decoding file handles, and was
> added in Linux 6.6[1]. However, I think this inode issue is only
> relevant for btree filesystems, and I think both btrfs and bcachefs both
> support decoding fhandles so this should work on fairly old kernels
> without issue (though I haven't checked).

> [1]: commit 96b2b072ee62 ("exportfs: allow exporting non-decodeable file handles to userspace")


Thanks, it's not too bad.  The name_to_handle_at manual page says that
the handle is supposed to be treated as an opaque value, although it
mentions AT_HANDLE_FID.  I think this needs to be fixed that it's
expected to compare the handle bytes, and also say whether it's
necessary to compare the type or not.

> Lennart suggested there should be a way to get this information from
> statx(2) so that you can get this new inode identifier without doing a
> bunch of extra syscalls to verify that inode didn't change between the
> two syscalls. I have a patchset for this, but I suspect it's too ugly
> (we can't return the full file handle so we need to hash it). I'll send
> an RFC later this week or next.

Hashing these things is rather nasty because it makes things impossible
to test.

>> How can we check for this?  The POSIX way is to compare st_ino and
>> st_dev in stat output, but if inode numbers are not unique, that will
>> result in files falsely being reported as identical.  It's harmless in
>> the temporary file case, but it in other scenarios, it may result in
>> data loss.
>
> (Another problem is that st_dev can be different for the same mount due
> to subvolumes.)

Uh-oh.  If st_dev are different, is it still possible that truncating
one path will affect the other with the different st_dev value?

Thanks,
Florian


