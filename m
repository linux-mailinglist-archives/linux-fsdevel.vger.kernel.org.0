Return-Path: <linux-fsdevel+bounces-77722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sWLxBOk3l2l2vwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:18:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C15116094F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 17:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A17E3010637
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104E34C81E;
	Thu, 19 Feb 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2kqW8xL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAA022A4FC;
	Thu, 19 Feb 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517926; cv=none; b=DWlL67LxVP2GbUd0Qzdk+K5QLP007XmFaPqSXMrejCjoSEihHSPh0j8XyfVnWLhEQpLa9sMn3wTDNEkh72V9tO9R6cF81IC5EQPWC2SaU3bkevRF9Kj6IRsPGQT7T20nq8Mmu1Eae2x/+pnONSlwipUtJVMtBxPDz/ho+NMpHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517926; c=relaxed/simple;
	bh=DC5amSNOmM7Ixn9On9eMnJ09Y9fdeTbTT8IaO12xmrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=optETZJzaPEDXKDocy+yK8orStUPodH+OT1+7Tz+jRsFCH++HVYJF8+Qr1exngTYT0eGm5BPswEoeWlCVKB49qHcXV++5G2Oa42YECGjE4rtOPWF9tB6p1fTmBSmVWaLm4rEXsumUKoxaBKetLk7WZClFghzsEAbjpq1TcgjYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2kqW8xL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771517924; x=1803053924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DC5amSNOmM7Ixn9On9eMnJ09Y9fdeTbTT8IaO12xmrs=;
  b=V2kqW8xLgele4v3FUI6iW9dmIpcaZwObq/WrfsIrlXaDCoGgFKGOYXNH
   T3pZAwoiSvjj/F68jmRhuWZt3gQQKDTf1k27DmJRKmOrV3JaYs4MTXuPJ
   ZUtEDQySpA4ue9Sn+MI4EoDoW1fASlI1wia6tuYwN2J2or6QJK29L/ZkU
   g0NtYSGtsozX3jx1+J/VgVNlRadjv5KcXzWkshIuekk884jbkiOScotAC
   JzAQZLlyit3Os8QasDvhUo5KEPoCSCtqzKzdByY9xOhkYLDRxM4TMaLtp
   0rp59vIIT80mi1ifH7y1/P6Rz6Es7e31i7krFhDkabD+3ND7cEP3x8NSb
   w==;
X-CSE-ConnectionGUID: 29iIfcc+QiWHur1WY0KLqQ==
X-CSE-MsgGUID: X5BDbRGXTrKWgwWyCnkwZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="98070461"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="98070461"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:18:43 -0800
X-CSE-ConnectionGUID: orUrHXxSTXiQQ4p5uFAFPw==
X-CSE-MsgGUID: zxSaD6lbSE6QJlO3eDgUMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219098453"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 08:18:40 -0800
Message-ID: <6f1b7b96-e732-43ca-88d0-b4cdf0203ccf@intel.com>
Date: Thu, 19 Feb 2026 09:18:38 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 08/19] dax: export dax_dev_get()
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223215.92448-1-john@jagalactic.com>
 <0100019bd33ce5b3-da53cf2e-141d-4bc2-94a8-aa5487eadfb5-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd33ce5b3-da53cf2e-141d-4bc2-94a8-aa5487eadfb5-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77722-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,groves.net:email]
X-Rspamd-Queue-Id: 8C15116094F
X-Rspamd-Action: no action



On 1/18/26 3:32 PM, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> famfs needs to look up a dax_device by dev_t when resolving fmap
> entries that reference character dax devices.
> 
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

It's tiny enough that maybe you can just squash it with the commit that you are using it?

> ---
>  drivers/dax/super.c | 3 ++-
>  include/linux/dax.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 00c330ef437c..d097561d78db 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -513,7 +513,7 @@ static int dax_set(struct inode *inode, void *data)
>  	return 0;
>  }
>  
> -static struct dax_device *dax_dev_get(dev_t devt)
> +struct dax_device *dax_dev_get(dev_t devt)
>  {
>  	struct dax_device *dax_dev;
>  	struct inode *inode;
> @@ -536,6 +536,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
>  
>  	return dax_dev;
>  }
> +EXPORT_SYMBOL_GPL(dax_dev_get);
>  
>  struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 6897c5736543..1ef9b03f9671 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -55,6 +55,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
>  void *dax_holder(struct dax_device *dax_dev);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
> +struct dax_device *dax_dev_get(dev_t devt);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
>  bool dax_synchronous(struct dax_device *dax_dev);


