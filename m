Return-Path: <linux-fsdevel+bounces-71673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83674CCC96C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1381301B138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8B33F8C3;
	Thu, 18 Dec 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bF/7l4Bp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6B33CEA1
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072838; cv=none; b=VCB1oN1xB/QvTNDj//8uCd+RQzELY43P22ZH+ut5BF9GPdTqSQD1TcwQOhdORnFdD/LWSj/oiNa8WD0jquwWPnp8MdWNRb3nc3OQf/cMfZovmYFRezgwa3xFQfCjyH1qmXxMhQGrC+5c5bC++vFGk2cT+cpoBKaGuRF5lnvitVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072838; c=relaxed/simple;
	bh=HM8UphKC+SOEZKYHL+PNUYmSvUmAKA2vk/5EcCfgq74=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kNhQpC4Zu0wQRVASw0bbE3bZVWypPCw9+m7YaMAnBxYN6ZtB71AbG4YUDHxW+iHzjCSu2Q3T4y+O0qEHI9g00B9ZGL9IgKm1iQAN8irA0o1nPRLqgnK5wCGFZ2wuBei7MF4FdQ/MU82wkXF9dNfelCwidUQlROT08bUcYypJCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bF/7l4Bp; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb002f72-3e2a-4d23-b08d-f6d987a29661@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766072819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dENL3ykrdrzuNo1GEY2zyPKnxqhaqBeqv7ZVRR/mohc=;
	b=bF/7l4Bp/uZHbGXv6xKoLUN5otIJgnSPCRQeA92+cQMBkjQWIftCfJedDQYvKyv5chw2R1
	IglgJHRafKN5Ias8qxRW/GupnLDq++S0U+Fx2RrCj8jLu2lNCDzSc+eGd2O/WRMasrjo/E
	1aa6jckMtlnLhBmMiCokmldd+Ao7ZJE=
Date: Thu, 18 Dec 2025 23:46:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ksmbd: Fix to handle removal of rfc1002 header from
 smb_hdr
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
To: David Howells <dhowells@redhat.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Steve French <sfrench@samba.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey
 <tom@talpey.com>, Paulo Alcantara <pc@manguebit.org>,
 Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <712257.1766069339@warthog.procyon.org.uk>
 <b5ebd3be-c567-44bb-9411-add5e79234dc@linux.dev>
Content-Language: en-US
In-Reply-To: <b5ebd3be-c567-44bb-9411-add5e79234dc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David,

Since the size of `struct smb_hdr` has changed, the value of 
`SMB1_MIN_SUPPORTED_HEADER_SIZE` should also be updated to 
`(sizeof(struct smb_hdr) + 4)`. `SMB1_MIN_SUPPORTED_HEADER_SIZE` is used 
in `ksmbd_conn_handler_loop()`.

Thanks,
ChenXiaoSong.

On 12/18/25 11:09 PM, ChenXiaoSong wrote:
> `ksmbd_conn_handler_loop()` calls `get_rfc1002_len()`. Does this need to 
> be updated as well?
> 
> Thanks,
> ChenXiaoSong.
> 
> On 12/18/25 10:48 PM, David Howells wrote:
>> Hi Namjae,
>>
>> Does this (untested) patch fix the problem for you?
>>
>> David
>> ---
>> The commit that removed the RFC1002 header from struct smb_hdr didn't 
>> also
>> fix the places in ksmbd that use it in order to provide graceful 
>> rejection
>> of SMB1 protocol requests.
>>
>> Fixes: 83bfbd0bb902 ("cifs: Remove the RFC1002 header from smb_hdr")
>> Reported-by: Namjae Jeon <linkinjeon@kernel.org>
>> Link: https://lore.kernel.org/r/ 
>> CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com/
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Steve French <sfrench@samba.org>
>> cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>> cc: Tom Talpey <tom@talpey.com>
>> cc: Paulo Alcantara <pc@manguebit.org>
>> cc: Shyam Prasad N <sprasad@microsoft.com>
>> cc: linux-cifs@vger.kernel.org
>> cc: netfs@lists.linux.dev
>> cc: linux-fsdevel@vger.kernel.org
>> ---
>>   fs/smb/server/server.c     |    2 +-
>>   fs/smb/server/smb_common.c |   10 +++++-----
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
>> index 3cea16050e4f..bedc8390b6db 100644
>> --- a/fs/smb/server/server.c
>> +++ b/fs/smb/server/server.c
>> @@ -95,7 +95,7 @@ static inline int check_conn_state(struct ksmbd_work 
>> *work)
>>       if (ksmbd_conn_exiting(work->conn) ||
>>           ksmbd_conn_need_reconnect(work->conn)) {
>> -        rsp_hdr = work->response_buf;
>> +        rsp_hdr = smb2_get_msg(work->response_buf);
>>           rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
>>           return 1;
>>       }
>> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
>> index b23203a1c286..d6084580b59d 100644
>> --- a/fs/smb/server/smb_common.c
>> +++ b/fs/smb/server/smb_common.c
>> @@ -140,7 +140,7 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
>>       if (smb2_hdr->ProtocolId == SMB2_PROTO_NUMBER)
>>           return ksmbd_smb2_check_message(work);
>> -    hdr = work->request_buf;
>> +    hdr = smb2_get_msg(work->request_buf);
>>       if (*(__le32 *)hdr->Protocol == SMB1_PROTO_NUMBER &&
>>           hdr->Command == SMB_COM_NEGOTIATE) {
>>           work->conn->outstanding_credits++;
>> @@ -278,7 +278,6 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
>>                             req->DialectCount);
>>       }
>> -    proto = *(__le32 *)((struct smb_hdr *)buf)->Protocol;
>>       if (proto == SMB1_PROTO_NUMBER) {
>>           struct smb_negotiate_req *req;
>> @@ -320,8 +319,8 @@ static u16 get_smb1_cmd_val(struct ksmbd_work *work)
>>    */
>>   static int init_smb1_rsp_hdr(struct ksmbd_work *work)
>>   {
>> -    struct smb_hdr *rsp_hdr = (struct smb_hdr *)work->response_buf;
>> -    struct smb_hdr *rcv_hdr = (struct smb_hdr *)work->request_buf;
>> +    struct smb_hdr *rsp_hdr = (struct smb_hdr *)smb2_get_msg(work- 
>> >response_buf);
>> +    struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb2_get_msg(work- 
>> >request_buf);
>>       rsp_hdr->Command = SMB_COM_NEGOTIATE;
>>       *(__le32 *)rsp_hdr->Protocol = SMB1_PROTO_NUMBER;
>> @@ -412,9 +411,10 @@ static int init_smb1_server(struct ksmbd_conn *conn)
>>   int ksmbd_init_smb_server(struct ksmbd_conn *conn)
>>   {
>> +    struct smb_hdr *rcv_hdr = (struct smb_hdr *)smb2_get_msg(conn- 
>> >request_buf);
>>       __le32 proto;
>> -    proto = *(__le32 *)((struct smb_hdr *)conn->request_buf)->Protocol;
>> +    proto = *(__le32 *)rcv_hdr->Protocol;
>>       if (conn->need_neg == false) {
>>           if (proto == SMB1_PROTO_NUMBER)
>>               return -EINVAL;
>>
>>
> 


