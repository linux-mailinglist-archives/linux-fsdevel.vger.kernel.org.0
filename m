Return-Path: <linux-fsdevel+bounces-75320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKAcJQf2c2nG0QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:28:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0517B26C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A42FC301D6B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7062D8375;
	Fri, 23 Jan 2026 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYjJaKA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4033985;
	Fri, 23 Jan 2026 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769207288; cv=none; b=DNTHCoKkQweYNWZwg/EffCM17UciCXi8+3L0L566d+p5PvRnBEsKZL/j6s/bZ12FHu+s8kEQIDo5Jxb2X7HtAd0q2/SRQW7GANQ8nSgpAEgiaTZxom5+HOB7Bt8fXqWBbD9G0qLPwc8BnNNuK3++AMGbP6Zbc2L+nPkCw82iKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769207288; c=relaxed/simple;
	bh=SHEFeXQcdidiqC75+qln6vEJi7rfdP/RgGe0/g1nOTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZu6PXw1mthtdCxBKDKQKn2VH7I+fLY4bREVdGhWM+Du2Vw5jR3VmXG0QOzA3jhlUVjXoYT+vsXK7pkfK82sGinOnw6dJxFWqK7Tkrvd8Bs9xFG99aAn8rKWIP8X0Z1qQSlygcWWHzZs8NWQShwl/JSdJ5ajj73QPdeK2IxdYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYjJaKA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6553EC4CEF1;
	Fri, 23 Jan 2026 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769207288;
	bh=SHEFeXQcdidiqC75+qln6vEJi7rfdP/RgGe0/g1nOTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VYjJaKA5iBV/acG4c6tNeP6LFmR/qS9E/LiycnppouEQpxgYosijGF/AfdNGl3zB6
	 p++cootJpavTy69o142hDWTobhaejcsSdHVviQM+6/jGeZMWfjiJzxYcCU2gxR9eTy
	 9v4yzJiIjY26Jg3b5YIOQ/MUDMtI6NEZZfg6iB15xmybLQTt5Yvg1k+IM0995614uA
	 hkBigebadCrIiLvU83cU5qUPEUexiRsJw85vDcbchTTEeNx6kiFy8l5rDqPtpkUn2G
	 km2dwaGFn0eQ2MOqCxMztGAMkeVMwlIfdnrK1DuM6uB0OaG7BMeSedBueMKKk9mgs5
	 Ohb8zsJ9ECGzg==
Message-ID: <8d024335-7be0-48f3-80d3-99bd85b6386b@kernel.org>
Date: Fri, 23 Jan 2026 17:28:02 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
 <5fb38378-a8e0-46d5-956c-de1a3bdaaf23@app.fastmail.com>
 <176920688733.16766.188886135069880896@noble.neil.brown.name>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <176920688733.16766.188886135069880896@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75320-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[hammerspace.com,oracle.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A0517B26C
X-Rspamd-Action: no action

On 1/23/26 5:21 PM, NeilBrown wrote:
> On Sat, 24 Jan 2026, Chuck Lever wrote:
>>
>> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
>>> NFS clients may bypass restrictive directory permissions by using
>>> open_by_handle() (or other available OS system call) to guess the
>>> filehandles for files below that directory.
>>>
>>> In order to harden knfsd servers against this attack, create a method to
>>> sign and verify filehandles using siphash as a MAC (Message Authentication
>>> Code).  Filehandles that have been signed cannot be tampered with, nor can
>>> clients reasonably guess correct filehandles and hashes that may exist in
>>> parts of the filesystem they cannot access due to directory permissions.
>>>
>>> Append the 8 byte siphash to encoded filehandles for exports that have set
>>> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
>>> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
>>> clients are verified by comparing the appended hash to the expected hash.
>>> If the MAC does not match the server responds with NFS error _BADHANDLE.
>>> If unsigned filehandles are received for an export with "sign_fh" they are
>>> rejected with NFS error _BADHANDLE.
>>>
>>> Link: 
>>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>> ---
>>>  fs/nfsd/nfsfh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>  fs/nfsd/nfsfh.h |  3 ++
>>>  2 files changed, 73 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>> index ed85dd43da18..ea3473acbf71 100644
>>> --- a/fs/nfsd/nfsfh.c
>>> +++ b/fs/nfsd/nfsfh.c
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/exportfs.h>
>>>
>>>  #include <linux/sunrpc/svcauth_gss.h>
>>> +#include <crypto/utils.h>
>>>  #include "nfsd.h"
>>>  #include "vfs.h"
>>>  #include "auth.h"
>>> @@ -137,6 +138,61 @@ static inline __be32 check_pseudo_root(struct 
>>> dentry *dentry,
>>>  	return nfs_ok;
>>>  }
>>>
>>> +/*
>>> + * Append an 8-byte MAC to the filehandle hashed from the server's 
>>> fh_key:
>>> + */
>>> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
>>> +{
>>> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>> +	struct knfsd_fh *fh = &fhp->fh_handle;
>>> +	siphash_key_t *fh_key = nn->fh_key;
>>> +	u64 hash;
>>> +
>>> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
>>> +		return 0;
>>> +
>>> +	if (!fh_key) {
>>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not 
>>> set.\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
>>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d 
>>> would be greater"
>>> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), 
>>> fhp->fh_maxsize);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	fh->fh_auth_type = FH_AT_MAC;
>>> +	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
>>> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
>>> +	fh->fh_size += sizeof(hash);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Verify that the the filehandle's MAC was hashed from this filehandle
>>> + * given the server's fh_key:
>>> + */
>>> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
>>> +{
>>> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>> +	struct knfsd_fh *fh = &fhp->fh_handle;
>>> +	siphash_key_t *fh_key = nn->fh_key;
>>> +	u64 hash;
>>> +
>>> +	if (fhp->fh_handle.fh_auth_type != FH_AT_MAC)
>>> +		return -EINVAL;
>>> +
>>> +	if (!fh_key) {
>>> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, 
>>> fh_key not set.\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	hash = siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
>>> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, 
>>> sizeof(hash));
>>> +}
>>> +
>>>  /*
>>>   * Use the given filehandle to look up the corresponding export and
>>>   * dentry.  On success, the results are used to set fh_export and
>>> @@ -166,8 +222,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
>>> *rqstp, struct net *net,
>>>
>>>  	if (--data_left < 0)
>>>  		return error;
>>> -	if (fh->fh_auth_type != 0)
>>> +
>>> +	/* either FH_AT_NONE or FH_AT_MAC */
>>> +	if (fh->fh_auth_type > 1)
>>>  		return error;
>>> +
>>>  	len = key_len(fh->fh_fsid_type) / 4;
>>>  	if (len == 0)
>>>  		return error;
>>> @@ -237,9 +296,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
>>> *rqstp, struct net *net,
>>>
>>>  	fileid_type = fh->fh_fileid_type;
>>>
>>> -	if (fileid_type == FILEID_ROOT)
>>> +	if (fileid_type == FILEID_ROOT) {
>>>  		dentry = dget(exp->ex_path.dentry);
>>> -	else {
>>> +	} else {
>>> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
>>> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
>>> +			goto out;
>>> +		}
>>> +
>>>  		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>>>  						data_left, fileid_type, 0,
>>>  						nfsd_acceptable, exp);
>>> @@ -495,6 +559,9 @@ static void _fh_update(struct svc_fh *fhp, struct 
>>> svc_export *exp,
>>>  		fhp->fh_handle.fh_fileid_type =
>>>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>>>  		fhp->fh_handle.fh_size += maxsize * 4;
>>> +
>>> +		if (fh_append_mac(fhp, exp->cd->net))
>>> +			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
>>>  	} else {
>>>  		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
>>>  	}
>>> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
>>> index 5ef7191f8ad8..7fff46ac2ba8 100644
>>> --- a/fs/nfsd/nfsfh.h
>>> +++ b/fs/nfsd/nfsfh.h
>>> @@ -59,6 +59,9 @@ struct knfsd_fh {
>>>  #define fh_fsid_type		fh_raw[2]
>>>  #define fh_fileid_type		fh_raw[3]
>>>
>>> +#define FH_AT_NONE		0
>>> +#define FH_AT_MAC		1
>>
>> I'm pleased at how much this patch has shrunk since v1.
>>
>> This might not be an actionable review comment, but help me understand
>> this particular point. Why do you need both a sign_fh export option
>> and a new FH auth type? Shouldn't the server just look for and
>> validate FH signatures whenever the sign_fh export option is
>> present?
> 
> ...and also generate valid signatures on outgoing file handles.
> 
> What does the server do to "look for" an FH signature so that it can
> "validate" it?  Answer: it inspects the fh_auth_type to see if it is
> FT_AT_MAC. 

No, NFSD checks the sign_fh export option. At first glance the two
seem redundant, and I might hesitate to inspect or not inspect
depending on information content received from a remote system. The
security policy is defined precisely by the "sign_fh" export option I
would think?


>> It seems a little subtle, so perhaps a code comment somewhere could
>> explain the need for both.
> 
> /* 
>  * FT_AT_MAC allows the server to detect if a signature is expected
>  * in the last 8 bytes of the file handle.
>  */
> 
> I wonder if it is really "last 8" for NFSv2 ...  or even if v2 is
> supported.  I should check the code I guess.

I believe NFSv2 is not supported.


>>
>>> +
>>>  static inline u32 *fh_fsid(const struct knfsd_fh *fh)
>>>  {
>>>  	return (u32 *)&fh->fh_raw[4];
>>> -- 
>>> 2.50.1
>>
>> -- 
>> Chuck Lever
>>
> 


-- 
Chuck Lever

