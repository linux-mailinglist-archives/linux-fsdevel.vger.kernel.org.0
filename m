Return-Path: <linux-fsdevel+bounces-52913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DAFAE8612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511D51898F8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4B13A86C;
	Wed, 25 Jun 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="fUpfW0LL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC112CDBE;
	Wed, 25 Jun 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861102; cv=none; b=KwOypK2FvL8lWbpfvpzsdf5utegSSKekVonYwCffznngKaOlUTVhIySEFhz83h/TA7j9trBBaK0QIcpoOqy8qG1+L7gg3bAxts4x1s60g1L5MWbOIGMNpDqOnL1+/30z+w3wkSvhuFNCGjFZejro2P/uTaOVQ+XaStgwOXBz5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861102; c=relaxed/simple;
	bh=8ilo5OhHjCfJ5SU0UVBQyLkd0GgpmgQmYKS8TKpYCMU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KcrseY8Khr38kY36YMWhEVgXgpL8Oh1ry8eIGhWFb1NWU7Nw5L65XqtkmOQmbtisn1W4gnJPccsyI+4cUHPf5H3N2TrOWK17pzd7VATq4v6iLfj88ZWx9vPq32LeABQwL8Sde0U1u4qG0ubC+Jlq5HERcOnj21yCmuplAdnV8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=fUpfW0LL; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=qxcAgrUtNt4ykReEVesHyOgm2yvv1QIqZbyndN7Aqjw=; b=fUpfW0LLuqcQIZQTclLc9tuI5O
	Tf3Xckm4xsbliiAUHALmc4EpqaEpC9pNeOvyFoEkZu/NB8jWq+6BLpoUr3Mp1yksJGsD3eY7OclZP
	d0FNP/aTxSSw05Z9qgvqtk0CXgWzaVOWkNYP97evvc2koapi1ujBIMBX07qRh+a+b8J87aGqnDsAI
	k2IVYbPzWvd1UiiKiIacU3612+q9LB7AQse0Ua8vL57VywqfJvqS8DRQZYN/LBWp+JSeoEH1JeG+r
	nvhBpjYFC874t6pkX+N2VNSTJrdb4hAJ0l4VcLoTDrg/rugFTMy6uG1mthS880lAsIF1W+Po8rznl
	vq6le0Y4l6YQS53en0VqrdReojIcgixDG6ei9mQubleho+i+SrbmFlFIpIsDduRqpg1qNqFutGPvC
	jtCTQn7DZrr0mSL7z26ug0Z7OU9mhXsmRSg+M+V1P2ip060twTFFm7IZXH0JdJgrb2GvUe3mEFB0y
	t0iJ4ezlENuS8MIhH8YcXlFo;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uUQx7-00CQdr-0z;
	Wed, 25 Jun 2025 14:18:17 +0000
Message-ID: <15a2d9f7-0945-4bb9-9879-e2a615b8f208@samba.org>
Date: Wed, 25 Jun 2025 16:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Collapse smbd_recv_*() into smbd_recv() and just
 use copy_to_iter()
From: Stefan Metzmacher <metze@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Steve French <stfrench@microsoft.com>
References: <1107690.1750683895@warthog.procyon.org.uk>
 <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org>
Content-Language: en-US
In-Reply-To: <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.06.25 um 14:25 schrieb Stefan Metzmacher:
> Hi David,
> 
> this looks very useful! Just a few comments below...
> 
>> Collapse smbd_recv_buf() and smbd_recv_page() into smbd_recv() and just use
>> copy_to_iter() instead of memcpy().
>>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Steve French <stfrench@microsoft.com>
>> cc: Tom Talpey <tom@talpey.com>
>> cc: Stefan Metzmacher <metze@samba.org>
>> cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
>> cc: Matthew Wilcox <willy@infradead.org>
>> cc: linux-cifs@vger.kernel.org
>> cc: netfs@lists.linux.dev
>> cc: linux-fsdevel@vger.kernel.org
>> ---
>>   fs/smb/client/smbdirect.c |  116 +++++++---------------------------------------
>>   1 file changed, 20 insertions(+), 96 deletions(-)
>>
>> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
>> index 5ae847919da5..dc64c337aae0 100644
>> --- a/fs/smb/client/smbdirect.c
>> +++ b/fs/smb/client/smbdirect.c
>> @@ -1747,35 +1747,39 @@ struct smbd_connection *smbd_get_connection(
>>   }
>>   /*
>> - * Receive data from receive reassembly queue
>> + * Receive data from the transport's receive reassembly queue
>>    * All the incoming data packets are placed in reassembly queue
>> - * buf: the buffer to read data into
>> + * iter: the buffer to read data into
>>    * size: the length of data to read
>>    * return value: actual data read
>> - * Note: this implementation copies the data from reassebmly queue to receive
>> + *
>> + * Note: this implementation copies the data from reassembly queue to receive
>>    * buffers used by upper layer. This is not the optimal code path. A better way
>>    * to do it is to not have upper layer allocate its receive buffers but rather
>>    * borrow the buffer from reassembly queue, and return it after data is
>>    * consumed. But this will require more changes to upper layer code, and also
>>    * need to consider packet boundaries while they still being reassembled.
>>    */
>> -static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>> -        unsigned int size)
>> +int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
>>   {
>>       struct smbdirect_socket *sc = &info->socket;
>>       struct smbd_response *response;
>>       struct smbdirect_data_transfer *data_transfer;
>> +    size_t size = msg->msg_iter.count;
> 
> I think this should be iov_iter_count()?
> 
>>       int to_copy, to_read, data_read, offset;
>>       u32 data_length, remaining_data_length, data_offset;
>>       int rc;
>> +    if (WARN_ON_ONCE(iov_iter_rw(&msg->msg_iter) == WRITE))
>> +        return -EINVAL; /* It's a bug in upper layer to get there */
>> +
>>   again:
>>       /*
>>        * No need to hold the reassembly queue lock all the time as we are
>>        * the only one reading from the front of the queue. The transport
>>        * may add more entries to the back of the queue at the same time
>>        */
>> -    log_read(INFO, "size=%d info->reassembly_data_length=%d\n", size,
>> +    log_read(INFO, "size=%zd info->reassembly_data_length=%d\n", size,
>>           info->reassembly_data_length);
>>       if (info->reassembly_data_length >= size) {
>>           int queue_length;
>> @@ -1811,9 +1815,12 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>>                * transport layer is added
>>                */
>>               if (response->first_segment && size == 4) {
>> -                unsigned int rfc1002_len =
>> +                unsigned int len =

Please keep the rfc1002_len variable as it's used in the log_read message below
and it should by host byteorder.

I'd propose a diff like this:

@@ -1846,8 +1850,11 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
                         if (response->first_segment && size == 4) {
                                 unsigned int rfc1002_len =
                                         data_length + remaining_data_length;
-                               *((__be32 *)buf) = cpu_to_be32(rfc1002_len);
+                               __be32 rfc1002_hdr = cpu_to_be32(rfc1002_len);
                                 data_read = 4;
+                               if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1002_hdr),
+                                                &msg->msg_iter) != data_read)
+                                       return -EFAULT;
                                 response->first_segment = false;
                                 log_read(INFO, "returning rfc1002 length %d\n",
                                         rfc1002_len);


>>                       data_length + remaining_data_length;
>> -                *((__be32 *)buf) = cpu_to_be32(rfc1002_len);
>> +                __be32 rfc1002_len = cpu_to_be32(len);
>> +                if (copy_to_iter(&rfc1002_len, sizeof(rfc1002_len),
>> +                         &msg->msg_iter) != sizeof(rfc1002_len))
>> +                    return -EFAULT;
>>                   data_read = 4;
>>                   response->first_segment = false;
>>                   log_read(INFO, "returning rfc1002 length %d\n",
>> @@ -1822,10 +1829,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>>               }
>>               to_copy = min_t(int, data_length - offset, to_read);
>> -            memcpy(
>> -                buf + data_read,
>> -                (char *)data_transfer + data_offset + offset,
>> -                to_copy);
>> +            if (copy_to_iter((char *)data_transfer + data_offset + offset,
>> +                     to_copy, &msg->msg_iter) != to_copy)
>> +                return -EFAULT;
>>               /* move on to the next buffer? */
>>               if (to_copy == data_length - offset) {
>> @@ -1870,6 +1876,8 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>>                data_read, info->reassembly_data_length,
>>                info->first_entry_offset);
>>   read_rfc1002_done:
>> +        /* SMBDirect will read it all or nothing */
>> +        msg->msg_iter.count = 0;
> 
> And this iov_iter_truncate(0);
> 
> While I'm wondering why we had this at all.
> 
> It seems all callers of cifs_read_iter_from_socket()
> don't care and the code path via sock_recvmsg() doesn't
> truncate it just calls copy_to_iter() via this chain:
> ->inet_recvmsg->tcp_recvmsg->skb_copy_datagram_msg->skb_copy_datagram_iter
> ->simple_copy_to_iter->copy_to_iter()
> 
> I think the old code should have called
> iov_iter_advance(rc) instead of msg->msg_iter.count = 0.
> 
> But the new code doesn't need it as copy_to_iter()
> calls iterate_and_advance().
> 
>>           return data_read;
>>       }
>> @@ -1890,90 +1898,6 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
>>       goto again;
>>   }
>> -/*
>> - * Receive a page from receive reassembly queue
>> - * page: the page to read data into
>> - * to_read: the length of data to read
>> - * return value: actual data read
>> - */
>> -static int smbd_recv_page(struct smbd_connection *info,
>> -        struct page *page, unsigned int page_offset,
>> -        unsigned int to_read)
>> -{
>> -    struct smbdirect_socket *sc = &info->socket;
>> -    int ret;
>> -    char *to_address;
>> -    void *page_address;
>> -
>> -    /* make sure we have the page ready for read */
>> -    ret = wait_event_interruptible(
>> -        info->wait_reassembly_queue,
>> -        info->reassembly_data_length >= to_read ||
>> -            sc->status != SMBDIRECT_SOCKET_CONNECTED);
>> -    if (ret)
>> -        return ret;
>> -
>> -    /* now we can read from reassembly queue and not sleep */
>> -    page_address = kmap_atomic(page);
>> -    to_address = (char *) page_address + page_offset;
>> -
>> -    log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
>> -        page, to_address, to_read);
>> -
>> -    ret = smbd_recv_buf(info, to_address, to_read);
>> -    kunmap_atomic(page_address);
>> -
>> -    return ret;
>> -}
>> -
>> -/*
>> - * Receive data from transport
>> - * msg: a msghdr point to the buffer, can be ITER_KVEC or ITER_BVEC
>> - * return: total bytes read, or 0. SMB Direct will not do partial read.
>> - */
>> -int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
>> -{
>> -    char *buf;
>> -    struct page *page;
>> -    unsigned int to_read, page_offset;
>> -    int rc;
>> -
>> -    if (iov_iter_rw(&msg->msg_iter) == WRITE) {
>> -        /* It's a bug in upper layer to get there */
>> -        cifs_dbg(VFS, "Invalid msg iter dir %u\n",
>> -             iov_iter_rw(&msg->msg_iter));
>> -        rc = -EINVAL;
>> -        goto out;
>> -    }
>> -
>> -    switch (iov_iter_type(&msg->msg_iter)) {
>> -    case ITER_KVEC:
>> -        buf = msg->msg_iter.kvec->iov_base;
>> -        to_read = msg->msg_iter.kvec->iov_len;
>> -        rc = smbd_recv_buf(info, buf, to_read);
>> -        break;
>> -
>> -    case ITER_BVEC:
>> -        page = msg->msg_iter.bvec->bv_page;
>> -        page_offset = msg->msg_iter.bvec->bv_offset;
>> -        to_read = msg->msg_iter.bvec->bv_len;
>> -        rc = smbd_recv_page(info, page, page_offset, to_read);
>> -        break;
>> -
>> -    default:
>> -        /* It's a bug in upper layer to get there */
>> -        cifs_dbg(VFS, "Invalid msg type %d\n",
>> -             iov_iter_type(&msg->msg_iter));
>> -        rc = -EINVAL;
>> -    }
> 
> I guess this is actually a real fix as I just saw
> CIFS: VFS: Invalid msg type 4
> in logs while running the cifs/001 test.
> And 4 is ITER_FOLIOQ.
> 
> So there might be something broken when ITER_FOLIOQ was
> introduced, but I wasn't able to find a specific commit.
> Maybe it was also already broken when using
> smb3 encryption over smbdirect, when ITER_XARRAY was still used.
> 
> metze
> 


