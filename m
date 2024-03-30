Return-Path: <linux-fsdevel+bounces-15811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A808932B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC341C20971
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC111465A0;
	Sun, 31 Mar 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VugHsG2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1314534A;
	Sun, 31 Mar 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902322; cv=pass; b=ESdQDCe4Ur1EHI8szOgK4uCfd+43a+vxS2otFNz8N6eWytOoeY1oVB3okLmRQcl/x/YAN/VK6fwfv9hQOThAAQTb2inQI12m+69CLwNejPJbi7u/wchUcbrHBmh8lh1VMnUYuzkRLtGeqRH2vZYPCgelSz10VfRsFUmiI1Z6cyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902322; c=relaxed/simple;
	bh=0Tab6a8G72hAdQQTifWJdxmg84+y/tA9VvkWPFI9VQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lto9dX420WP6VrzvfITVbUGZ2ZhsgIkbmDB4cVbM8ydvq9I4bYXWibPZvzqX8FQ2ECYSslRkmydFpOFohLhrdJffjbq54Qu7bXg8EUk7mmF+xMdmS2rFbFj6j6R4SnvkEghhB14xILQn6lFEx4/iFgoRg1FldpJ2erx59S7/NtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VugHsG2Y; arc=none smtp.client-ip=91.218.175.173; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 371B7207D1;
	Sun, 31 Mar 2024 18:25:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WUSdENQcNLv9; Sun, 31 Mar 2024 18:25:15 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EF8B7207E4;
	Sun, 31 Mar 2024 18:25:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EF8B7207E4
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id DE83D800053;
	Sun, 31 Mar 2024 18:25:14 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:25:14 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:39 +0000
X-sender: <netdev+bounces-83486-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoA+Zbp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAfAAAAj4oAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 27491
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83486-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 29E82201E5
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760782; cv=none; b=dASfLrrkRxmD6WmYvcvyTFgLXAgqW4qcP8FwVw/FT8ajSayU1k2jNzB6oEhlAk4YxWiFWUStYosH2VKaROBs5wKHQh4Rsxe59gs4L4KuJN+VlHKDa1iIm9ShtgGS6jAthHnsiMpAE+me1GueQZILnQSEjyu5ZoBpE9mg1Ojzukk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760782; c=relaxed/simple;
	bh=0Tab6a8G72hAdQQTifWJdxmg84+y/tA9VvkWPFI9VQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9cTiVFLYlA2DR+fBNIsoiV/11LbFxExG+qAmCsON2fksIZjZEAFWqHQx2zJk8Dqn3t/Quqw4LH8Yjb2qqlthM0L82RcciykTG9EQ9SPWlqiRoPPhuerZSz/amNX1IgyImsufFdXk4+oiQpzCA0LsWzVgTdTI9x4oenmDhjahZI=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VugHsG2Y; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08dd01e3-c45e-47d9-bcde-55f7d1edc480@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711760777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFgFwDTUylEnErMgQV0Ufr9/Ufnl/0omKSnqywixpVg=;
	b=VugHsG2Y5vYBP20CvcOMmGaEI/5A/PvLnTsQTtTA0ZebTuac4nORyH8iRZe/CwFs5RLRhJ
	4Ih/prbwbd8/OSA0Wv9Z9Z9JdeLOJUf8/vLW1xeGCG/2qNeI4CXYcIw3EixotT7o6oviEg
	ZM4gfY/Y4bUjm5TsY8pyZBWQLZ0Jv74=
Date: Fri, 29 Mar 2024 18:06:09 -0700
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 19/26] netfs: New writeback implementation
Content-Language: en-US
To: Naveen Mamindlapalli <naveenm@marvell.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
 "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
 "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-20-dhowells@redhat.com>
 <SJ2PR18MB5635A86C024316BC5E57B79EA23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <SJ2PR18MB5635A86C024316BC5E57B79EA23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On 29/03/2024 10:34, Naveen Mamindlapalli wrote:
>> -----Original Message-----
>> From: David Howells <dhowells@redhat.com>
>> Sent: Thursday, March 28, 2024 10:04 PM
>> To: Christian Brauner <christian@brauner.io>; Jeff Layton <jlayton@kernel.org>;
>> Gao Xiang <hsiangkao@linux.alibaba.com>; Dominique Martinet
>> <asmadeus@codewreck.org>
>> Cc: David Howells <dhowells@redhat.com>; Matthew Wilcox
>> <willy@infradead.org>; Steve French <smfrench@gmail.com>; Marc Dionne
>> <marc.dionne@auristor.com>; Paulo Alcantara <pc@manguebit.com>; Shyam
>> Prasad N <sprasad@microsoft.com>; Tom Talpey <tom@talpey.com>; Eric Van
>> Hensbergen <ericvh@kernel.org>; Ilya Dryomov <idryomov@gmail.com>;
>> netfs@lists.linux.dev; linux-cachefs@redhat.com; linux-afs@lists.infradead.org;
>> linux-cifs@vger.kernel.org; linux-nfs@vger.kernel.org; ceph-
>> devel@vger.kernel.org; v9fs@lists.linux.dev; linux-erofs@lists.ozlabs.org; linux-
>> fsdevel@vger.kernel.org; linux-mm@kvack.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Latchesar Ionkov <lucho@ionkov.net>; Christian
>> Schoenebeck <linux_oss@crudebyte.com>
>> Subject: [PATCH 19/26] netfs: New writeback implementation
>>
>> The current netfslib writeback implementation creates writeback requests of
>> contiguous folio data and then separately tiles subrequests over the space
>> twice, once for the server and once for the cache.  This creates a few
>> issues:
>>
>>   (1) Every time there's a discontiguity or a change between writing to only
>>       one destination or writing to both, it must create a new request.
>>       This makes it harder to do vectored writes.
>>
>>   (2) The folios don't have the writeback mark removed until the end of the
>>       request - and a request could be hundreds of megabytes.
>>
>>   (3) In future, I want to support a larger cache granularity, which will
>>       require aggregation of some folios that contain unmodified data (which
>>       only need to go to the cache) and some which contain modifications
>>       (which need to be uploaded and stored to the cache) - but, currently,
>>       these are treated as discontiguous.
>>
>> There's also a move to get everyone to use writeback_iter() to extract
>> writable folios from the pagecache.  That said, currently writeback_iter()
>> has some issues that make it less than ideal:
>>
>>   (1) there's no way to cancel the iteration, even if you find a "temporary"
>>       error that means the current folio and all subsequent folios are going
>>       to fail;
>>
>>   (2) there's no way to filter the folios being written back - something
>>       that will impact Ceph with it's ordered snap system;
>>
>>   (3) and if you get a folio you can't immediately deal with (say you need
>>       to flush the preceding writes), you are left with a folio hanging in
>>       the locked state for the duration, when really we should unlock it and
>>       relock it later.
>>
>> In this new implementation, I use writeback_iter() to pump folios,
>> progressively creating two parallel, but separate streams and cleaning up
>> the finished folios as the subrequests complete.  Either or both streams
>> can contain gaps, and the subrequests in each stream can be of variable
>> size, don't need to align with each other and don't need to align with the
>> folios.
>>
>> Indeed, subrequests can cross folio boundaries, may cover several folios or
>> a folio may be spanned by multiple folios, e.g.:
>>
>>           +---+---+-----+-----+---+----------+
>> Folios:  |   |   |     |     |   |          |
>>           +---+---+-----+-----+---+----------+
>>
>>             +------+------+     +----+----+
>> Upload:    |      |      |.....|    |    |
>>             +------+------+     +----+----+
>>
>>           +------+------+------+------+------+
>> Cache:   |      |      |      |      |      |
>>           +------+------+------+------+------+
>>
>> The progressive subrequest construction permits the algorithm to be
>> preparing both the next upload to the server and the next write to the
>> cache whilst the previous ones are already in progress.  Throttling can be
>> applied to control the rate of production of subrequests - and, in any
>> case, we probably want to write them to the server in ascending order,
>> particularly if the file will be extended.
>>
>> Content crypto can also be prepared at the same time as the subrequests and
>> run asynchronously, with the prepped requests being stalled until the
>> crypto catches up with them.  This might also be useful for transport
>> crypto, but that happens at a lower layer, so probably would be harder to
>> pull off.
>>
>> The algorithm is split into three parts:
>>
>>   (1) The issuer.  This walks through the data, packaging it up, encrypting
>>       it and creating subrequests.  The part of this that generates
>>       subrequests only deals with file positions and spans and so is usable
>>       for DIO/unbuffered writes as well as buffered writes.
>>
>>   (2) The collector. This asynchronously collects completed subrequests,
>>       unlocks folios, frees crypto buffers and performs any retries.  This
>>       runs in a work queue so that the issuer can return to the caller for
>>       writeback (so that the VM can have its kswapd thread back) or async
>>       writes.
>>
>>   (3) The retryer.  This pauses the issuer, waits for all outstanding
>>       subrequests to complete and then goes through the failed subrequests
>>       to reissue them.  This may involve reprepping them (with cifs, the
>>       credits must be renegotiated, and a subrequest may need splitting),
>>       and doing RMW for content crypto if there's a conflicting change on
>>       the server.
>>
>> [!] Note that some of the functions are prefixed with "new_" to avoid
>> clashes with existing functions.  These will be renamed in a later patch
>> that cuts over to the new algorithm.
>>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Jeff Layton <jlayton@kernel.org>
>> cc: Eric Van Hensbergen <ericvh@kernel.org>
>> cc: Latchesar Ionkov <lucho@ionkov.net>
>> cc: Dominique Martinet <asmadeus@codewreck.org>
>> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
>> cc: Marc Dionne <marc.dionne@auristor.com>
>> cc: v9fs@lists.linux.dev
>> cc: linux-afs@lists.infradead.org
>> cc: netfs@lists.linux.dev
>> cc: linux-fsdevel@vger.kernel.org

[..snip..]

>> +/*
>> + * Begin a write operation for writing through the pagecache.
>> + */
>> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *iocb, size_t
>> len)
>> +{
>> +	struct netfs_io_request *wreq = NULL;
>> +	struct netfs_inode *ictx = netfs_inode(file_inode(iocb->ki_filp));
>> +
>> +	mutex_lock(&ictx->wb_lock);
>> +
>> +	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp,
>> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
>> +	if (IS_ERR(wreq))
>> +		mutex_unlock(&ictx->wb_lock);
>> +
>> +	wreq->io_streams[0].avail = true;
>> +	trace_netfs_write(wreq, netfs_write_trace_writethrough);
> 
> Missing mutex_unlock() before return.
> 

mutex_unlock() happens in new_netfs_end_writethrough()

> Thanks,
> Naveen
> 



