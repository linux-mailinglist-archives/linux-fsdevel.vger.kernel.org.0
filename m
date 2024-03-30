Return-Path: <linux-fsdevel+bounces-15812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F49989339D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955C3288995
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA4C14BF83;
	Sun, 31 Mar 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VugHsG2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340714B067;
	Sun, 31 Mar 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903090; cv=fail; b=GEbfNPxyIfXq3Kbwdwbt8eQ4zpr+fN9SnDHZNfqVNzjZ0S4A4i1ZQzBVoHrpx/AU8QsMHxNZ/YFWs/okO9T3aGD3/vWOIOM9WtH/pMnuNkZOgVxbnEdM7zjDVnVeJb3QoRYZ03qeuURxq0H7PTaiuPGmtZ1rWpBoP7A0ufs0+sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903090; c=relaxed/simple;
	bh=dWMO/lOg0gePvHK49stRRjFv1uKnqxL14eF+MadiWUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO5iny15sHOIrgl4I96KwREabemuqRYJLYDXoa3XZ+CM1xpG+ygrDpwyJSAE3CcDecp9dazWn7PhCcj8ktujaiQBHxvEV4Kt52DPsBleRfpQJKw4bhE4/gGfiew/LIsepAA9RaPovDB4WHu1iVG5reAUqynwt2Hyatb0x1F5E68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VugHsG2Y reason="signature verification failed"; arc=none smtp.client-ip=91.218.175.182; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 40B74207E4;
	Sun, 31 Mar 2024 18:38:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlgNFKZGbSVs; Sun, 31 Mar 2024 18:38:00 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EC8B7207FD;
	Sun, 31 Mar 2024 18:37:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EC8B7207FD
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id DD53980004A;
	Sun, 31 Mar 2024 18:37:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:37:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:20 +0000
X-sender: <linux-kernel+bounces-125561-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoA3kymlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKADIAAADQigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 27438
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125561-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7AE8920847
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760783; cv=none; b=eQMLIM3E3vC1fcfr7QPtAQIpBm5D/DQ5nbet5fJmSZleovRyoxau2snQi72aO1TzlzgS5k4khrdezEgHPJMG+BNkzJMSw6FopjQNhUwEYoZS1xoARA+0fUM/nlOo+C0LFouufIIblUWLdmlSMvYsj1pJgOtyDxrmVMl2G7A8JUY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760783; c=relaxed/simple;
	bh=0Tab6a8G72hAdQQTifWJdxmg84+y/tA9VvkWPFI9VQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1L0GBShyUfqsn6VvqqPsGVcef0/0+Su3BiDDri8AYSw2Tm6sFPgcsO5B786NS8cdmDPjuer6wtR8AutcMTwPZp4Wd2K6VRRe7ZaUU3BnJP8YPQUtBHNQYSt/yCGns+w71mx60RSjYvdktBv/+0Lzos4yFLliQBn7gOIDp7LcOQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VugHsG2Y; arc=none smtp.client-ip=91.218.175.182
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
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On 29/03/2024 10:34, Naveen Mamindlapalli wrote:
>> -----Original Message-----
>> From: David Howells <dhowells@redhat.com>
>> Sent: Thursday, March 28, 2024 10:04 PM
>> To: Christian Brauner <christian@brauner.io>; Jeff Layton <jlayton@kerne=
l.org>;
>> Gao Xiang <hsiangkao@linux.alibaba.com>; Dominique Martinet
>> <asmadeus@codewreck.org>
>> Cc: David Howells <dhowells@redhat.com>; Matthew Wilcox
>> <willy@infradead.org>; Steve French <smfrench@gmail.com>; Marc Dionne
>> <marc.dionne@auristor.com>; Paulo Alcantara <pc@manguebit.com>; Shyam
>> Prasad N <sprasad@microsoft.com>; Tom Talpey <tom@talpey.com>; Eric Van
>> Hensbergen <ericvh@kernel.org>; Ilya Dryomov <idryomov@gmail.com>;
>> netfs@lists.linux.dev; linux-cachefs@redhat.com; linux-afs@lists.infrade=
ad.org;
>> linux-cifs@vger.kernel.org; linux-nfs@vger.kernel.org; ceph-
>> devel@vger.kernel.org; v9fs@lists.linux.dev; linux-erofs@lists.ozlabs.or=
g; linux-
>> fsdevel@vger.kernel.org; linux-mm@kvack.org; netdev@vger.kernel.org; lin=
ux-
>> kernel@vger.kernel.org; Latchesar Ionkov <lucho@ionkov.net>; Christian
>> Schoenebeck <linux_oss@crudebyte.com>
>> Subject: [PATCH 19/26] netfs: New writeback implementation
>>
>> The current netfslib writeback implementation creates writeback requests=
 of
>> contiguous folio data and then separately tiles subrequests over the spa=
ce
>> twice, once for the server and once for the cache.  This creates a few
>> issues:
>>
>>   (1) Every time there's a discontiguity or a change between writing to =
only
>>       one destination or writing to both, it must create a new request.
>>       This makes it harder to do vectored writes.
>>
>>   (2) The folios don't have the writeback mark removed until the end of =
the
>>       request - and a request could be hundreds of megabytes.
>>
>>   (3) In future, I want to support a larger cache granularity, which wil=
l
>>       require aggregation of some folios that contain unmodified data (w=
hich
>>       only need to go to the cache) and some which contain modifications
>>       (which need to be uploaded and stored to the cache) - but, current=
ly,
>>       these are treated as discontiguous.
>>
>> There's also a move to get everyone to use writeback_iter() to extract
>> writable folios from the pagecache.  That said, currently writeback_iter=
()
>> has some issues that make it less than ideal:
>>
>>   (1) there's no way to cancel the iteration, even if you find a "tempor=
ary"
>>       error that means the current folio and all subsequent folios are g=
oing
>>       to fail;
>>
>>   (2) there's no way to filter the folios being written back - something
>>       that will impact Ceph with it's ordered snap system;
>>
>>   (3) and if you get a folio you can't immediately deal with (say you ne=
ed
>>       to flush the preceding writes), you are left with a folio hanging =
in
>>       the locked state for the duration, when really we should unlock it=
 and
>>       relock it later.
>>
>> In this new implementation, I use writeback_iter() to pump folios,
>> progressively creating two parallel, but separate streams and cleaning u=
p
>> the finished folios as the subrequests complete.  Either or both streams
>> can contain gaps, and the subrequests in each stream can be of variable
>> size, don't need to align with each other and don't need to align with t=
he
>> folios.
>>
>> Indeed, subrequests can cross folio boundaries, may cover several folios=
 or
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
>> cache whilst the previous ones are already in progress.  Throttling can =
be
>> applied to control the rate of production of subrequests - and, in any
>> case, we probably want to write them to the server in ascending order,
>> particularly if the file will be extended.
>>
>> Content crypto can also be prepared at the same time as the subrequests =
and
>> run asynchronously, with the prepped requests being stalled until the
>> crypto catches up with them.  This might also be useful for transport
>> crypto, but that happens at a lower layer, so probably would be harder t=
o
>> pull off.
>>
>> The algorithm is split into three parts:
>>
>>   (1) The issuer.  This walks through the data, packaging it up, encrypt=
ing
>>       it and creating subrequests.  The part of this that generates
>>       subrequests only deals with file positions and spans and so is usa=
ble
>>       for DIO/unbuffered writes as well as buffered writes.
>>
>>   (2) The collector. This asynchronously collects completed subrequests,
>>       unlocks folios, frees crypto buffers and performs any retries.  Th=
is
>>       runs in a work queue so that the issuer can return to the caller f=
or
>>       writeback (so that the VM can have its kswapd thread back) or asyn=
c
>>       writes.
>>
>>   (3) The retryer.  This pauses the issuer, waits for all outstanding
>>       subrequests to complete and then goes through the failed subreques=
ts
>>       to reissue them.  This may involve reprepping them (with cifs, the
>>       credits must be renegotiated, and a subrequest may need splitting)=
,
>>       and doing RMW for content crypto if there's a conflicting change o=
n
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
>> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *ioc=
b, size_t
>> len)
>> +{
>> +	struct netfs_io_request *wreq =3D NULL;
>> +	struct netfs_inode *ictx =3D netfs_inode(file_inode(iocb->ki_filp));
>> +
>> +	mutex_lock(&ictx->wb_lock);
>> +
>> +	wreq =3D netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_fil=
p,
>> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
>> +	if (IS_ERR(wreq))
>> +		mutex_unlock(&ictx->wb_lock);
>> +
>> +	wreq->io_streams[0].avail =3D true;
>> +	trace_netfs_write(wreq, netfs_write_trace_writethrough);
>=20
> Missing mutex_unlock() before return.
>=20

mutex_unlock() happens in new_netfs_end_writethrough()

> Thanks,
> Naveen
>=20


X-sender: <netdev+bounces-83486-peter.schumann=3Dsecunet.com@vger.kernel.or=
g>
X-Receiver: <peter.schumann@secunet.com> ORCPT=3Drfc822;peter.schumann@secu=
net.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAMAAIAAAUAWAAXAEgAAACdOWm+FoEIR=
7KnWe1lIx8pQ049U2NodW1hbm4gUGV0ZXIsT1U9VXNlcnMsT1U9TWlncmF0aW9uLERDPXNlY3Vu=
ZXQsREM9ZGUFAGwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmV=
jaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAA=
BtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3f=
fGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3Vw=
IChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LEN=
OPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3=
VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2Z=
SBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5u=
NWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAVABYAAgA=
AAA8ANQAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5Jc1Jlc2=
91cmNlAgAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3Bvb=
nNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5F=
eGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXh=
wYW5zaW9uBQAmAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoA3kymlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3Vu=
ZXQuY29tBQAGAAIAAQ8AKgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuUmVzdWJtaXR=
Db3VudAcAAwAAAA8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQ=
UAYgAKADEAAADQigAABQBkAA8AAwAAAEh1YgUAKQACAAEPAD8AAABNaWNyb3NvZnQuRXhjaGFuZ=
2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuTWFpbERlbGl2ZXJ5UHJpb3JpdHkPAAMAAABMb3c=
=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 28032
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 02:06:35 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 02:06:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3EE60201E5
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 02:06:35 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (1024-bit key) header.d=3Dlinux.dev
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6tvewKec8aDo for <peter.schumann@secunet.com>;
	Sat, 30 Mar 2024 02:06:31 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83486-peter.schumann=3Dsecunet.com@vger.kernel.org; receiver=3Dpeter.sc=
humann@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 617F120519
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 617F120519
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 02:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2491AB2154C
	for <peter.schumann@secunet.com>; Sat, 30 Mar 2024 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78810FF;
	Sat, 30 Mar 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Dlinux.dev header.i=3D@linux.dev head=
er.b=3D"VugHsG2Y"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175=
.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E77E8
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D91.218.175.173
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711760782; cv=3Dnone; b=3DdASfLrrkRxmD6WmYvcvyTFgLXAgqW4qcP8FwVw/FT8a=
jSayU1k2jNzB6oEhlAk4YxWiFWUStYosH2VKaROBs5wKHQh4Rsxe59gs4L4KuJN+VlHKDa1iIm9=
ShtgGS6jAthHnsiMpAE+me1GueQZILnQSEjyu5ZoBpE9mg1Ojzukk=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711760782; c=3Drelaxed/simple;
	bh=3D0Tab6a8G72hAdQQTifWJdxmg84+y/tA9VvkWPFI9VQA=3D;
	h=3DMessage-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=3DJ9cTiVFLYlA2DR+fBNIsoiV/11LbFxExG+qAmCsON2f=
ksIZjZEAFWqHQx2zJk8Dqn3t/Quqw4LH8Yjb2qqlthM0L82RcciykTG9EQ9SPWlqiRoPPhuerZS=
z/amNX1IgyImsufFdXk4+oiQpzCA0LsWzVgTdTI9x4oenmDhjahZI=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlinux.dev; spf=3Dpass smtp.mailfrom=3Dli=
nux.dev; dkim=3Dpass (1024-bit key) header.d=3Dlinux.dev header.i=3D@linux.=
dev header.b=3DVugHsG2Y; arc=3Dnone smtp.client-ip=3D91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlinux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlinux.dev
Message-ID: <08dd01e3-c45e-47d9-bcde-55f7d1edc480@linux.dev>
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dlinux.dev; =
s=3Dkey1;
	t=3D1711760777;
	h=3Dfrom:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DBFgFwDTUylEnErMgQV0Ufr9/Ufnl/0omKSnqywixpVg=3D;
	b=3DVugHsG2Y5vYBP20CvcOMmGaEI/5A/PvLnTsQTtTA0ZebTuac4nORyH8iRZe/CwFs5RLRhJ
	4Ih/prbwbd8/OSA0Wv9Z9Z9JdeLOJUf8/vLW1xeGCG/2qNeI4CXYcIw3EixotT7o6oviEg
	ZM4gfY/Y4bUjm5TsY8pyZBWQLZ0Jv74=3D
Date: Fri, 29 Mar 2024 18:06:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 19/26] netfs: New writeback implementation
Content-Language: en-US
To: Naveen Mamindlapalli <naveenm@marvell.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>=
,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>=
,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>=
,
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
 <SJ2PR18MB5635A86C024316BC5E57B79EA23A2@SJ2PR18MB5635.namprd18.prod.outloo=
k.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and inc=
lude these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <SJ2PR18MB5635A86C024316BC5E57B79EA23A2@SJ2PR18MB5635.namprd18=
.prod.outlook.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Return-Path: netdev+bounces-83486-peter.schumann=3Dsecunet.com@vger.kernel.=
org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 01:06:35.2990
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 407005da-cf0f-43eb-e721-08dc=
5055a526
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D25969.715|SMR=3D0.330(SMRDE=3D0.005|SMRC=3D0.=
324(SMRCL=3D0.103|X-SMRCR=3D0.323))|CAT=3D0.079(CATOS=3D0.001
 |CATRESL=3D0.033(CATRESLP2R=3D0.026)|CATORES=3D0.043(CATRS=3D0.043(CATRS-I=
ndex
 Routing Agent=3D0.041
 )))|QDM=3D5760.243|SMSC=3D0.016|SMS=3D2.529(SMSMBXD-INC=3D2.522)|UNK=3D0.0=
01|QDM=3D5821.174|SMSC=3D0.014
 |SMS=3D3.274(SMSMBXD-INC=3D3.267)|QDM=3D8272.090|SMSC=3D0.022|SMS=3D4.740(=
SMSMBXD-INC=3D4.719
 )|QDM=3D6095.229|UNK=3D0.001|CAT=3D0.027(CATRESL=3D0.026(CATRESLP2R=3D0.01=
2))|QDM=3D5.054|UNK=3D0.004
 |CAT=3D0.022(CATRESL=3D0.020(CATRESLP2R=3D0.009))|QDM=3D5.047|UNK=3D0.004|=
CAT=3D0.005(CATRESL=3D0.004
 (CATRESLP2R=3D0.002));2024-03-30T08:19:25.041Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 15012
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.025|SMR=3D0.022(SMRPI=3D0.020(SMRPI-FrontendProxyAgent=3D0.020))=
|SMS=3D0.002
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAZIQAAAPAAADH4sIAAAAAAAEAJ1Ze29b=
x7E/lMSnHnYedp
 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
 Je4mo4sHrI8CzuykD6Q5H1PLHnPj8/o0CX2SGddc4nOZaHbtdFYuOh
 +ow++3x1OpceIDWZvITc+R93HIHXdSfByX9Tv1cvvv/mmwfXkWcIBh
 wUl29AWZs7pBrphiTG8cOL5Bxz86Mjx2vFcVaV5s05VaPDXxOn44eL
 IX+9SupEkoPkAVMMQFKvH3T8cHw+0wyR6DTrK/0Vv1/+CbvmVCBfPH
 n9x1fnP7x89vrJ66cvv/3+T0+PamYB7h0+e3X+5OXLQxLy6OjqIaKn
 1N130vT4IdzhbtQ/3vtpoC9RNaA+PGBqR9N7mXExwcZgCfqqNnMuNP
 VY4SPxq56j0lBYrol3BEBEzBpXqwdMu9/boPEtJEJ+FZbordeD8ojz
 hN7psgtuQdz/Szqe+70o2oq2txpRD78YRNs7jWazETUj/LZbUXs/Om
 hGNztRtx29txO1mlGrHXU7jeiDqIvV7aiLyU7Uw5YD/EatrWgHHDpR
 1In2Me5GPdB3G9GHNOhsRc2dqNmKOu1G9H7UYQ697WgHZ4Hm38CH+H
 e2oxY2dqIDHHQb24mmu0VkG6cTcSvaa9JMi8lIQvDvEP8uxpjhE/d2
 GtHHNGhDFyHrRrtQ/Ga07Tf2sNqItvHvVtSRScgGbtuk2o6cCG7bUa
 cX7bUa0XtsIpkUwfyhZJBbfAp/JZN+7KRty9f/YOZNJ3YXM79iPiyt
 o/mEacLMjme7miHDNuun/Ls/1DGJdqHOR1GnzvZ9ctO2bGmRhdur1W
 h3Y6ZLZuk0yVDCEwIf7Eb7TWJL4on8bZINbKOtxjZ9sk9l9SD6CAPo
 3mFXHkQ32mzeDvm03Yt2m86qpKl83YW/eKZJIdGW8bZzwU742mS9wK
 0RbcEprcYHjShqsGphHgEMZTHAXsxwEG7vRDewHadg7Gda/NnkGNhi
 gT/YYdtiHpNbnB2QOZwi8gThoZEcyoYl8baI5qDNEQ6esiRM8Nlt3B
 Y+zJ9ExXaRR6RlO+wzf7KYSCsSykGwFafkTQkbkZAPdcYX+UG5H30i
 cgYtRHhP3GVH3xLJxSD70UdtNm8QDEsiOSlLGQF92yzwXofz0dthj+
 WhwPZkuyGMg6gyaDbeFyPIoWK0louc3XAui7EtEopSImcwNUwhu2AN
 BrH3rmMrhmXV2t3ow5BxMhDD0kzNy8JBnNj0abvr1ZQl+Mjn1A6nTN
 fPN8WGcuhWtB9kEIIOh434osV4ImEjgyazFcMeRDclMuvGF3BDkItP
 OxxsDNcd76+2DIK7d8lfuy2/He4TYwZd6pEm6nPM7Av+i1OaHqyCQe
 rzlIzRzRYHrazit+fHAoNbnGiyPaQhywnJv25F/2i0ov9tNKNEJIKH
 96J9UQsGZqHaknMhuLZ8UgbbS8Jtc6S0vCVkiz9wt8fhucXwIILIXo
 yxhM/d6GDbRWJnx2dwXd1w7hYXkyaLGiJXCDrR+x7+d/xMd4NGNN1m
 AQ44rQNwitnYWp2WF5U3tkVN4eBT56DltRBKsXSTJRRuHtUka/eDVU
 OGhdRk1boBS5hty7sAmXcrYAMbaqee38gwSZQQL11X8FshslrRe/Uk
 lr1XsVbwANVDysgu41PLezbEO1sMUXFDmAh6NT26h/BYj5aDLjtaCI
 JTZJWxQQrmzbo8bZ+40iM0V9lzWxJIhAmgItywKjG24/EyALmHkwNB
 IJDtsT2hQs8jaDe6Hawne1sOg6lo4Fz+KhjzYYA0h9keG/gU0agnZ7
 FJ90IUrcdMb4MPs/oAbcK+g4erfRk1a1caPTfJjq53T90tB5n1LsNN
 As82ekB2/Wb3EY5b7/J4fq1F6pC0m82Xm6z1ayuy9qp1gh1+hVUxix
 hTGgoW4xMCdZafDdjdpl7MIR/QgCGfAgnytKgg4JRbG1s4JG7I5C5n
 685qTBt7Lo9a6FvbFK4fNWmytbM2eVt23WZLNl0LGVZbjUbUpWakW5
 s8lnGL/Os6xL3oYxjBT4LDx5jf4+Z6/Swa96hr7vjmCwQ3muRfZ0+q
 G43oP/3XvehWm33N3LqcYgfhq6vY1A67ON+LPmwBGf4f/nChsmgpAA
 ABCtYZPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2
 Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZX
 JzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBTdGFydEluZGV4
 PSIxMDUiIFBvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdH
 Jpbmc+ZGhvd2VsbHNAcmVkaGF0LmNvbTwvRW1haWxTdHJpbmc+DQog
 ICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0iMTk3Ii
 BQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVtYWlsU3RyaW5nPmNo
 cmlzdGlhbkBicmF1bmVyLmlvPC9FbWFpbFN0cmluZz4NCiAgICA8L0
 VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSIyMzMiIFBvc2l0
 aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+amxheXRvbk
 BrZXJuZWwub3JnPC9FbWFpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0K
 ICAgIDxFbWFpbCBTdGFydEluZGV4PSIyNjkiIFBvc2l0aW9uPSJPdG
 hlciI+DQogICAgICA8RW1haWxTdHJpbmc+aHNpYW5na2FvQGxpbnV4
 LmFsaWJhYmEuY29tPC9FbWFpbFN0cmluZz4NCiAgICA8L0VtYWlsPg
 0KICAgIDxFbWFpbCBTdGFydEluZGV4PSIzMjMiIFBvc2l0aW9uPSJP
 dGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+YXNtYWRldXNAY29kZX
 dyZWNrLm9yZzwvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAg
 ICA8RW1haWwgU3RhcnRJbmRleD0iNDEyIiBQb3NpdGlvbj0iT3RoZX
 IiPg0KICAgICAgPEVtYWlsU3RyaW5nPndpbGx5QGluZnJhZGVhZC5v
 cmc8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogICAgPEVtYW
 lsIFN0YXJ0SW5kZXg9IjQ0OCIgUG9zaXRpb249Ik90aGVyIj4NCiAg
 ICAgIDxFbWFpbFN0cmluZz5zbWZyZW5jaEBnbWFpbC5jb208L0VtYW
 lsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0
 SW5kZXg9IjQ4NiIgUG9zaXRpb249Ik90aGVyIj4NCiAgICAgIDxFbW
 FpbFN0cmluZz5tYXJjLmRpb25uZUBhdXJpc3Rvci5jb208L0VtYWls
 U3RyaW5nPg0KICAgIDwvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW
 5kZXg9IjUzMCIgUG9zaXRpb249Ik90aGVyIj4NCiAgICAgIDxFbWFp
 bFN0cmluZz5wY0BtYW5ndWViaXQuY29tPC9FbWFpbFN0cmluZz4NCi
 AgICA8L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSI1Njki
 IFBvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+c3
 ByYXNhZEBtaWNyb3NvZnQuY29tPC9FbWFpbFN0cmluZz4NCiAgICA8
 L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSI2MDUiIFBvc2
 l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+dG9tQHRh
 bHBleS5jb208L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogIC
 AgPEVtYWlsIFN0YXJ0SW5kZXg9IjY0NyIgUG9zaXRpb249Ik90aGVy
 Ij4NCiAgICAgIDxFbWFpbFN0cmluZz5lcmljdmhAa2VybmVsLm9yZz
 wvRW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwg
 U3RhcnRJbmRleD0iNjgxIiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgIC
 AgPEVtYWlsU3RyaW5nPmlkcnlvbW92QGdtYWlsLmNvbTwvRW1haWxT
 dHJpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbm
 RleD0iNzA2IiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVtYWls
 U3RyaW5nPm5ldGZzQGxpc3RzLmxpbnV4LmRldjwvRW1haWxTdHJpbm
 c+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0i
 NzI5IiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVtYWlsU3RyaW
 5nPmxpbnV4LWNhY2hlZnNAcmVkaGF0LmNvbTwvRW1haWxTdHJpbmc+
 DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0iNz
 U1IiBQb3NpdGlvbj0iT3RoZXIiPg0KICAgICAgPEVtYWlsU3RyaW5n
 PmxpbnV4LWFmc0BsaXN0cy5pbmZyYWRlYWQub3JnPC9FbWFpbFN0cm
 luZz4NCiAgICA8L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4
 PSI3OTAiIFBvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdH
 Jpbmc+bGludXgtY2lmc0B2Z2VyLmtlcm5lbC5vcmc8L0VtYWlsU3Ry
 aW5nPg0KICAgIDwvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW5kZX
 g9IjgxOCIgUG9zaXRpb249Ik90aGVyIj4NCiAgICAgIDxFbWFpbFN0
 cmluZz5saW51eC1uZnNAdmdlci5rZXJuZWwub3JnPC9FbWFpbFN0cm
 luZz4NCiAgICA8L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4
 PSI4NTUiIFBvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdH
 Jpbmc+ZGV2ZWxAdmdlci5rZXJuZWwub3JnPC9FbWFpbFN0cmluZz4N
 CiAgICA8L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSI4Nz
 giIFBvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+
 djlmc0BsaXN0cy5saW51eC5kZXY8L0VtYWlsU3RyaW5nPg0KICAgID
 wvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjkwMCIgUG9z
 aXRpb249Ik90aGVyIj4NCiAgICAgIDxFbWFpbFN0cmluZz5saW51eC
 1lcm9mc0BsaXN0cy5vemxhYnMub3JnPC9FbWFpbFN0cmluZz4NCiAg
 ICA8L0VtYWlsPg0KICAgIDxFbWFpbCBTdGFydEluZGV4PSI5NDEiIF
 Bvc2l0aW9uPSJPdGhlciI+DQogICAgICA8RW1haWxTdHJpbmc+ZnNk
 ZXZlbEB2Z2VyLmtlcm5lbC5vcmc8L0VtYWlsU3RyaW5nPg0KICAgID
 wvRW1haWw+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9Ijk2NiIgUG9z
 aXRpb249Ik90aGVyIj4NCiAgICAgIDxFbWFpbFN0cmluZz5saW51eC
 1tbUBrdmFjay5vcmc8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+
 DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9Ijk4NiIgUG9zaXRpb249Ik
 90aGVyIj4NCiAgICAgIDxFbWFpbFN0cmluZz5uZXRkZXZAdmdlci5r
 ZXJuZWwub3JnPC9FbWFpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KIC
 AgIDxFbWFpbCBTdGFydEluZGV4PSIxMDIxIiBQb3NpdGlvbj0iT3Ro
 ZXIiPg0KICAgICAgPEVtYWlsU3RyaW5nPmtlcm5lbEB2Z2VyLmtlcm
 5lbC5vcmc8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogICAg
 PEVtYWlsIFN0YXJ0SW5kZXg9IjEwNjMiIFBvc2l0aW9uPSJPdGhlci
 I+DQogICAgICA8RW1haWxTdHJpbmc+bHVjaG9AaW9ua292Lm5ldDwv
 RW1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgICA8RW1haWwgU3
 RhcnRJbmRleD0iMTEwOSIgUG9zaXRpb249Ik90aGVyIj4NCiAgICAg
 IDxFbWFpbFN0cmluZz5saW51eF9vc3NAY3J1ZGVieXRlLmNvbTwvRW
 1haWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8
 L0VtYWlsU2V0PgEOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMCwwO1JldH
 JpZXZlck9wZXJhdG9yLDExLDM7UG9zdERvY1BhcnNlck9wZXJhdG9y
 LDEwLDI7UG9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcm
 RCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEwLDY7UG9zdFdvcmRC
 cmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3
 JpdGVyUHJvZHVjZXIsMjAsOQ=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 7753
X-MS-Exchange-Forest-EmailMessageHash: E2F20B10
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:RC:REDACTED-015ab0b5b79b98c9c0=
7fb4b31a88d5d2@secunet.com:12/10|SR
X-MS-Exchange-Organization-IncludeInSla: False:RecipientCountThresholdExcee=
ded

On 29/03/2024 10:34, Naveen Mamindlapalli wrote:
>> -----Original Message-----
>> From: David Howells <dhowells@redhat.com>
>> Sent: Thursday, March 28, 2024 10:04 PM
>> To: Christian Brauner <christian@brauner.io>; Jeff Layton <jlayton@kerne=
l.org>;
>> Gao Xiang <hsiangkao@linux.alibaba.com>; Dominique Martinet
>> <asmadeus@codewreck.org>
>> Cc: David Howells <dhowells@redhat.com>; Matthew Wilcox
>> <willy@infradead.org>; Steve French <smfrench@gmail.com>; Marc Dionne
>> <marc.dionne@auristor.com>; Paulo Alcantara <pc@manguebit.com>; Shyam
>> Prasad N <sprasad@microsoft.com>; Tom Talpey <tom@talpey.com>; Eric Van
>> Hensbergen <ericvh@kernel.org>; Ilya Dryomov <idryomov@gmail.com>;
>> netfs@lists.linux.dev; linux-cachefs@redhat.com; linux-afs@lists.infrade=
ad.org;
>> linux-cifs@vger.kernel.org; linux-nfs@vger.kernel.org; ceph-
>> devel@vger.kernel.org; v9fs@lists.linux.dev; linux-erofs@lists.ozlabs.or=
g; linux-
>> fsdevel@vger.kernel.org; linux-mm@kvack.org; netdev@vger.kernel.org; lin=
ux-
>> kernel@vger.kernel.org; Latchesar Ionkov <lucho@ionkov.net>; Christian
>> Schoenebeck <linux_oss@crudebyte.com>
>> Subject: [PATCH 19/26] netfs: New writeback implementation
>>
>> The current netfslib writeback implementation creates writeback requests=
 of
>> contiguous folio data and then separately tiles subrequests over the spa=
ce
>> twice, once for the server and once for the cache.  This creates a few
>> issues:
>>
>>   (1) Every time there's a discontiguity or a change between writing to =
only
>>       one destination or writing to both, it must create a new request.
>>       This makes it harder to do vectored writes.
>>
>>   (2) The folios don't have the writeback mark removed until the end of =
the
>>       request - and a request could be hundreds of megabytes.
>>
>>   (3) In future, I want to support a larger cache granularity, which wil=
l
>>       require aggregation of some folios that contain unmodified data (w=
hich
>>       only need to go to the cache) and some which contain modifications
>>       (which need to be uploaded and stored to the cache) - but, current=
ly,
>>       these are treated as discontiguous.
>>
>> There's also a move to get everyone to use writeback_iter() to extract
>> writable folios from the pagecache.  That said, currently writeback_iter=
()
>> has some issues that make it less than ideal:
>>
>>   (1) there's no way to cancel the iteration, even if you find a "tempor=
ary"
>>       error that means the current folio and all subsequent folios are g=
oing
>>       to fail;
>>
>>   (2) there's no way to filter the folios being written back - something
>>       that will impact Ceph with it's ordered snap system;
>>
>>   (3) and if you get a folio you can't immediately deal with (say you ne=
ed
>>       to flush the preceding writes), you are left with a folio hanging =
in
>>       the locked state for the duration, when really we should unlock it=
 and
>>       relock it later.
>>
>> In this new implementation, I use writeback_iter() to pump folios,
>> progressively creating two parallel, but separate streams and cleaning u=
p
>> the finished folios as the subrequests complete.  Either or both streams
>> can contain gaps, and the subrequests in each stream can be of variable
>> size, don't need to align with each other and don't need to align with t=
he
>> folios.
>>
>> Indeed, subrequests can cross folio boundaries, may cover several folios=
 or
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
>> cache whilst the previous ones are already in progress.  Throttling can =
be
>> applied to control the rate of production of subrequests - and, in any
>> case, we probably want to write them to the server in ascending order,
>> particularly if the file will be extended.
>>
>> Content crypto can also be prepared at the same time as the subrequests =
and
>> run asynchronously, with the prepped requests being stalled until the
>> crypto catches up with them.  This might also be useful for transport
>> crypto, but that happens at a lower layer, so probably would be harder t=
o
>> pull off.
>>
>> The algorithm is split into three parts:
>>
>>   (1) The issuer.  This walks through the data, packaging it up, encrypt=
ing
>>       it and creating subrequests.  The part of this that generates
>>       subrequests only deals with file positions and spans and so is usa=
ble
>>       for DIO/unbuffered writes as well as buffered writes.
>>
>>   (2) The collector. This asynchronously collects completed subrequests,
>>       unlocks folios, frees crypto buffers and performs any retries.  Th=
is
>>       runs in a work queue so that the issuer can return to the caller f=
or
>>       writeback (so that the VM can have its kswapd thread back) or asyn=
c
>>       writes.
>>
>>   (3) The retryer.  This pauses the issuer, waits for all outstanding
>>       subrequests to complete and then goes through the failed subreques=
ts
>>       to reissue them.  This may involve reprepping them (with cifs, the
>>       credits must be renegotiated, and a subrequest may need splitting)=
,
>>       and doing RMW for content crypto if there's a conflicting change o=
n
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
>> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *ioc=
b, size_t
>> len)
>> +{
>> +	struct netfs_io_request *wreq =3D NULL;
>> +	struct netfs_inode *ictx =3D netfs_inode(file_inode(iocb->ki_filp));
>> +
>> +	mutex_lock(&ictx->wb_lock);
>> +
>> +	wreq =3D netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_fil=
p,
>> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
>> +	if (IS_ERR(wreq))
>> +		mutex_unlock(&ictx->wb_lock);
>> +
>> +	wreq->io_streams[0].avail =3D true;
>> +	trace_netfs_write(wreq, netfs_write_trace_writethrough);
>=20
> Missing mutex_unlock() before return.
>=20

mutex_unlock() happens in new_netfs_end_writethrough()

> Thanks,
> Naveen
>=20


X-sender: <netdev+bounces-83486-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoANE2mlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbm=
dlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAA=
AAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1h=
aWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 15568
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 02:06:35 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 02:06:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B2D8120847
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 02:06:34 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (1024-bit key) header.d=3Dlinux.dev
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTuZ69sK9a_2 for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 02:06:31 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dnetdev+bou=
nces-83486-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteff=
en.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 29E82201E5
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 29E82201E5
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 02:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EA61C21430
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB85617D2;
	Sat, 30 Mar 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Dlinux.dev header.i=3D@linux.dev head=
er.b=3D"VugHsG2Y"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175=
.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E77E8
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D91.218.175.173
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711760782; cv=3Dnone; b=3DdASfLrrkRxmD6WmYvcvyTFgLXAgqW4qcP8FwVw/FT8a=
jSayU1k2jNzB6oEhlAk4YxWiFWUStYosH2VKaROBs5wKHQh4Rsxe59gs4L4KuJN+VlHKDa1iIm9=
ShtgGS6jAthHnsiMpAE+me1GueQZILnQSEjyu5ZoBpE9mg1Ojzukk=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711760782; c=3Drelaxed/simple;
	bh=3D0Tab6a8G72hAdQQTifWJdxmg84+y/tA9VvkWPFI9VQA=3D;
	h=3DMessage-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=3DJ9cTiVFLYlA2DR+fBNIsoiV/11LbFxExG+qAmCsON2f=
ksIZjZEAFWqHQx2zJk8Dqn3t/Quqw4LH8Yjb2qqlthM0L82RcciykTG9EQ9SPWlqiRoPPhuerZS=
z/amNX1IgyImsufFdXk4+oiQpzCA0LsWzVgTdTI9x4oenmDhjahZI=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlinux.dev; spf=3Dpass smtp.mailfrom=3Dli=
nux.dev; dkim=3Dpass (1024-bit key) header.d=3Dlinux.dev header.i=3D@linux.=
dev header.b=3DVugHsG2Y; arc=3Dnone smtp.client-ip=3D91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlinux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlinux.dev
Message-ID: <08dd01e3-c45e-47d9-bcde-55f7d1edc480@linux.dev>
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dlinux.dev; =
s=3Dkey1;
	t=3D1711760777;
	h=3Dfrom:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DBFgFwDTUylEnErMgQV0Ufr9/Ufnl/0omKSnqywixpVg=3D;
	b=3DVugHsG2Y5vYBP20CvcOMmGaEI/5A/PvLnTsQTtTA0ZebTuac4nORyH8iRZe/CwFs5RLRhJ
	4Ih/prbwbd8/OSA0Wv9Z9Z9JdeLOJUf8/vLW1xeGCG/2qNeI4CXYcIw3EixotT7o6oviEg
	ZM4gfY/Y4bUjm5TsY8pyZBWQLZ0Jv74=3D
Date: Fri, 29 Mar 2024 18:06:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 19/26] netfs: New writeback implementation
Content-Language: en-US
To: Naveen Mamindlapalli <naveenm@marvell.com>,
 David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>=
,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>=
,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>=
,
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
 <SJ2PR18MB5635A86C024316BC5E57B79EA23A2@SJ2PR18MB5635.namprd18.prod.outloo=
k.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and inc=
lude these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <SJ2PR18MB5635A86C024316BC5E57B79EA23A2@SJ2PR18MB5635.namprd18=
.prod.outlook.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Return-Path: netdev+bounces-83486-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 01:06:34.7524
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 87894eac-5cd8-4523-8273-08dc=
5055a4d3
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dcas-es=
sen-01.secunet.de:TOTAL-FE=3D0.012|SMR=3D0.012(SMRPI=3D0.009(SMRPI-Frontend=
ProxyAgent=3D0.009));2024-03-30T01:06:34.764Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-OriginalSize: 15019
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:ShadowRedundancy
X-MS-Exchange-Organization-IncludeInSla: False:ShadowRedundancy

On 29/03/2024 10:34, Naveen Mamindlapalli wrote:
>> -----Original Message-----
>> From: David Howells <dhowells@redhat.com>
>> Sent: Thursday, March 28, 2024 10:04 PM
>> To: Christian Brauner <christian@brauner.io>; Jeff Layton <jlayton@kerne=
l.org>;
>> Gao Xiang <hsiangkao@linux.alibaba.com>; Dominique Martinet
>> <asmadeus@codewreck.org>
>> Cc: David Howells <dhowells@redhat.com>; Matthew Wilcox
>> <willy@infradead.org>; Steve French <smfrench@gmail.com>; Marc Dionne
>> <marc.dionne@auristor.com>; Paulo Alcantara <pc@manguebit.com>; Shyam
>> Prasad N <sprasad@microsoft.com>; Tom Talpey <tom@talpey.com>; Eric Van
>> Hensbergen <ericvh@kernel.org>; Ilya Dryomov <idryomov@gmail.com>;
>> netfs@lists.linux.dev; linux-cachefs@redhat.com; linux-afs@lists.infrade=
ad.org;
>> linux-cifs@vger.kernel.org; linux-nfs@vger.kernel.org; ceph-
>> devel@vger.kernel.org; v9fs@lists.linux.dev; linux-erofs@lists.ozlabs.or=
g; linux-
>> fsdevel@vger.kernel.org; linux-mm@kvack.org; netdev@vger.kernel.org; lin=
ux-
>> kernel@vger.kernel.org; Latchesar Ionkov <lucho@ionkov.net>; Christian
>> Schoenebeck <linux_oss@crudebyte.com>
>> Subject: [PATCH 19/26] netfs: New writeback implementation
>>
>> The current netfslib writeback implementation creates writeback requests=
 of
>> contiguous folio data and then separately tiles subrequests over the spa=
ce
>> twice, once for the server and once for the cache.  This creates a few
>> issues:
>>
>>   (1) Every time there's a discontiguity or a change between writing to =
only
>>       one destination or writing to both, it must create a new request.
>>       This makes it harder to do vectored writes.
>>
>>   (2) The folios don't have the writeback mark removed until the end of =
the
>>       request - and a request could be hundreds of megabytes.
>>
>>   (3) In future, I want to support a larger cache granularity, which wil=
l
>>       require aggregation of some folios that contain unmodified data (w=
hich
>>       only need to go to the cache) and some which contain modifications
>>       (which need to be uploaded and stored to the cache) - but, current=
ly,
>>       these are treated as discontiguous.
>>
>> There's also a move to get everyone to use writeback_iter() to extract
>> writable folios from the pagecache.  That said, currently writeback_iter=
()
>> has some issues that make it less than ideal:
>>
>>   (1) there's no way to cancel the iteration, even if you find a "tempor=
ary"
>>       error that means the current folio and all subsequent folios are g=
oing
>>       to fail;
>>
>>   (2) there's no way to filter the folios being written back - something
>>       that will impact Ceph with it's ordered snap system;
>>
>>   (3) and if you get a folio you can't immediately deal with (say you ne=
ed
>>       to flush the preceding writes), you are left with a folio hanging =
in
>>       the locked state for the duration, when really we should unlock it=
 and
>>       relock it later.
>>
>> In this new implementation, I use writeback_iter() to pump folios,
>> progressively creating two parallel, but separate streams and cleaning u=
p
>> the finished folios as the subrequests complete.  Either or both streams
>> can contain gaps, and the subrequests in each stream can be of variable
>> size, don't need to align with each other and don't need to align with t=
he
>> folios.
>>
>> Indeed, subrequests can cross folio boundaries, may cover several folios=
 or
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
>> cache whilst the previous ones are already in progress.  Throttling can =
be
>> applied to control the rate of production of subrequests - and, in any
>> case, we probably want to write them to the server in ascending order,
>> particularly if the file will be extended.
>>
>> Content crypto can also be prepared at the same time as the subrequests =
and
>> run asynchronously, with the prepped requests being stalled until the
>> crypto catches up with them.  This might also be useful for transport
>> crypto, but that happens at a lower layer, so probably would be harder t=
o
>> pull off.
>>
>> The algorithm is split into three parts:
>>
>>   (1) The issuer.  This walks through the data, packaging it up, encrypt=
ing
>>       it and creating subrequests.  The part of this that generates
>>       subrequests only deals with file positions and spans and so is usa=
ble
>>       for DIO/unbuffered writes as well as buffered writes.
>>
>>   (2) The collector. This asynchronously collects completed subrequests,
>>       unlocks folios, frees crypto buffers and performs any retries.  Th=
is
>>       runs in a work queue so that the issuer can return to the caller f=
or
>>       writeback (so that the VM can have its kswapd thread back) or asyn=
c
>>       writes.
>>
>>   (3) The retryer.  This pauses the issuer, waits for all outstanding
>>       subrequests to complete and then goes through the failed subreques=
ts
>>       to reissue them.  This may involve reprepping them (with cifs, the
>>       credits must be renegotiated, and a subrequest may need splitting)=
,
>>       and doing RMW for content crypto if there's a conflicting change o=
n
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
>> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *ioc=
b, size_t
>> len)
>> +{
>> +	struct netfs_io_request *wreq =3D NULL;
>> +	struct netfs_inode *ictx =3D netfs_inode(file_inode(iocb->ki_filp));
>> +
>> +	mutex_lock(&ictx->wb_lock);
>> +
>> +	wreq =3D netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_fil=
p,
>> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
>> +	if (IS_ERR(wreq))
>> +		mutex_unlock(&ictx->wb_lock);
>> +
>> +	wreq->io_streams[0].avail =3D true;
>> +	trace_netfs_write(wreq, netfs_write_trace_writethrough);
>=20
> Missing mutex_unlock() before return.
>=20

mutex_unlock() happens in new_netfs_end_writethrough()

> Thanks,
> Naveen
>=20



