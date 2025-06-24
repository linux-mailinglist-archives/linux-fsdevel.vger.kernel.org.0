Return-Path: <linux-fsdevel+bounces-52790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B7AE6C10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 18:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5361188C231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748082E1723;
	Tue, 24 Jun 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="zGIPsK6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D952D29BA;
	Tue, 24 Jun 2025 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781162; cv=none; b=sqb/ll2R9AMhIkz9/OoL5Eolrhkqa6TIWA5viU4/KlE9RfKC7HHJEgFK+7tMlhuFTyuzuSaZsH2TjyMsfYO+tOcg1tdeBxWudtBJrJWM/0t6Z0wilCdAJA0mIRKRvWxx47CNDas1EhGTgi+RZSqEv1jdpsuMA5Y42qZI6GJDKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781162; c=relaxed/simple;
	bh=bF5g9fm7RdA0Rke6tEu8cQUmmrjjnJgKtwfhpKG/Pwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UECbBUXohSmkWUdKlf8X/0TraLsa5jDh7XCqDyBdXpzmcwlsSDde9okDTyUauSyWqgE5MO9FvAIMH/7fCJi7qOt9Q6l2q5NITohR+FNV8cEvortuRfdCjHbu6CvGONHigFBMdKoRR8ljgAvRhsGOqp/9yRERnNY2fa9+eo3WMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=zGIPsK6e; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=qeKHSJSc7h9EilvDhUbXYddD2Qf+Xlbu+2oqu4eNTNs=; b=zGIPsK6e6nSmCXhYJgocjO1+lp
	u+7N6jdOH2B3KA9cRLfFpD79Qv1A5y84fH+0W2sqHV3rLjH0zF4bc4ElwrRr+2XVt0emqGY4R6wHA
	TguONeqHn9YA0L77eZevW2FOTK885lo/1x1MKvyhZGobDJQhzon6GeZG//x/d7DnemJOgHC0pOYNt
	FMMcHYipPnxYCouMonCFcsfQ5/c4COCLRWVIKxl9egx6+JqVrkvJkWDmJXiQ8SScdW3bYL+jHEocD
	89TIUzd2Bmp5qCh64y+levRIMzp0JVu/BgpVYlvb6oTOBPczrZxRheXmEEkNiovbqgBomNsYmSKIY
	dkaiiB3JkPMXqF2GRQhDBpJbw/kI/pJIEDUPswi7b3Rk4g1Qwe2VJN8UQJh4plN5DEOkztNIS0m9C
	rm1T9P+vudczLEb0/U0H8mdK2n1eorVovh/0pBcMjLPHou/zCnWTdgmRmNrQVhM8a4gQ5QXUjEJzp
	bUZYjuFGY9rdUDwQyZT0AEV1;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uU69f-00CHYM-36;
	Tue, 24 Jun 2025 16:05:52 +0000
Message-ID: <1758512f-5783-4b9a-9692-d2f1a09eef4a@samba.org>
Date: Tue, 24 Jun 2025 18:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Collapse smbd_recv_*() into smbd_recv() and just
 use copy_to_iter()
To: David Howells <dhowells@redhat.com>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Steve French <stfrench@microsoft.com>
References: <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org>
 <1107690.1750683895@warthog.procyon.org.uk>
 <1156127.1750774971@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <1156127.1750774971@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

>>>    read_rfc1002_done:
>>> +		/* SMBDirect will read it all or nothing */
>>> +		msg->msg_iter.count = 0;
>>
>> And this iov_iter_truncate(0);
> 
> Actually, it should probably have been iov_iter_advance().
> 
>> While I'm wondering why we had this at all.
>>
>> It seems all callers of cifs_read_iter_from_socket()
>> don't care and the code path via sock_recvmsg() doesn't
>> truncate it just calls copy_to_iter() via this chain:
>> ->inet_recvmsg->tcp_recvmsg->skb_copy_datagram_msg->skb_copy_datagram_iter
>> ->simple_copy_to_iter->copy_to_iter()
>>
>> I think the old code should have called
>> iov_iter_advance(rc) instead of msg->msg_iter.count = 0.
>>
>> But the new code doesn't need it as copy_to_iter()
>> calls iterate_and_advance().
> 
> Yeah, it should.  I seem to remember that there were situations in which it
> didn't, but it's possible I managed to get rid of them.
> 
>>> -	default:
>>> -		/* It's a bug in upper layer to get there */
>>> -		cifs_dbg(VFS, "Invalid msg type %d\n",
>>> -			 iov_iter_type(&msg->msg_iter));
>>> -		rc = -EINVAL;
>>> -	}
>>
>> I guess this is actually a real fix as I just saw
>> CIFS: VFS: Invalid msg type 4
>> in logs while running the cifs/001 test.
>> And 4 is ITER_FOLIOQ.
> 
> Ah... Were you using "-o seal"?  The encrypted data is held in a buffer formed
> from a folioq with a series of folios in it.


In local.config I have this:

[smb3-1-rdma]
FSTYP=cifs
TEST_DEV=//172.31.9.1/TEST
TEST_DIR=/mnt/test
TEST_FS_MOUNT_OPTS='-ousername=administrator,password=...,rdma,noperm,vers=3.0,mfsymlinks,actimeo=0'
export MOUNT_OPTIONS='-ousername=administrator,password=...,rdma,noperm,mfsymlinks,actimeo=0'
export SCRATCH_DEV=//172.31.9.1/SCRATCH
export SCRATCH_MNT=/mnt/scratch

And called:

./check -s smb3-1-rdma -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt cifs/001

So I don't think it used seal, I'm also not seeing encrypted stuff in the capture,
so maybe the folioq iter comes from a higher layer (via cifs_readv_receive()) instead
of receive_encrypted_read().

metze


