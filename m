Return-Path: <linux-fsdevel+bounces-77548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAltD7+JlWnqSAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:43:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC510154D02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7053F302A1B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D833D4FF;
	Wed, 18 Feb 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHnyFxlc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="llG4ruJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD42367D9
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407797; cv=none; b=bD4pPTZo+4LySZ5bETOn0jXMS8Rq8xJytZPg8LdZGD55EFGzjX34jj9eDEjW2E3jGIjslcXwMGx2aqKGF4OdLbhUHWSu1670vm6+q36rYRHpWaAPEHlayH2lovFBtySmJoxbWRwoXWYayaaG85lYGEWXcdSBLXh6lLaQ3g2lDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407797; c=relaxed/simple;
	bh=7MlMSQiD44nGkm9QdFDfkQrwjXCe6pqty82o5oGxOvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw5WYbE8xF6BHmtlE1Rt458+nGHrqSeNKS3sdF3p/b4pd9dKv1K0PKup7WIwa2wW2/iPT/02q4XmlMcqfG9oSsiYbTTVkOQZ4BR3eUHi6qcPW37xqFPHDsw5Tx5LFt+snIA010R57frwxFXhBVWcUY06lGWWGCu6KaMCiN6IZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHnyFxlc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=llG4ruJ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771407794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=acxJsX/Fq0LQyGsW9dYw2IB/+V+2/p4bzlJYGYuBU/A=;
	b=JHnyFxlcbukAMrtuuohPJmaVQJLCKJHtWzgkgtVwjgnE8kbJRfKWbGhTpy9HF91QrQ1VwB
	8vMymtz7PBoVjpgzKjkuOHXK8f2060PWGdmpDP4aYEo6hKe1/+XlHD2UMKjlWl1DPnIhsj
	IS0f1bU0D/xVsUYFeK4ZCpf+fBu8cxI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-PT8M6fvKPGKyzXa7F4EzNA-1; Wed, 18 Feb 2026 04:43:12 -0500
X-MC-Unique: PT8M6fvKPGKyzXa7F4EzNA-1
X-Mimecast-MFC-AGG-ID: PT8M6fvKPGKyzXa7F4EzNA_1771407792
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483101623e9so45045215e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771407792; x=1772012592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acxJsX/Fq0LQyGsW9dYw2IB/+V+2/p4bzlJYGYuBU/A=;
        b=llG4ruJ2HOStO8LT8TRUUj379Pscpw8QjTukO7zbmZ8g2YO0Ueqv+uA1/sl7LYpk90
         dw5kHWPGc9iN/aenBEvmSMXoanJyOve1c7wwbW2JkqcbXxFdpQMkQusF/99Er5x1l12d
         n3G8dRyEec3+mA25eDGauLTuRiY5fh1rUwS5h7YKEVzbnzGewgq/TXmywjTwuh75zZh4
         zInD1Z0hmYN87vA+19ZlxEAOIhV9qgfLXOpgKwxQNZBDl7NrtgmVu21mzWNa+bDkxvl8
         gwBBaMTgEDcOVUAJ3kzzc2QALHG5kWGYLOLfSeRwx9zuoYAxjW3TLi0Jvc4+wprHgtTG
         XbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771407792; x=1772012592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acxJsX/Fq0LQyGsW9dYw2IB/+V+2/p4bzlJYGYuBU/A=;
        b=s0rCdQJXBFl6jTxOicpyY45OjBI2VDVFz6zioMaTi6L/ruSasbQHneaJpmVvn5iNXB
         Uf3xwbOrkRWU0rebEAHdL4/UneyU3uvjmvKx4/VOFt2WNyKs0LXSduWhKDQkW3s0VaH0
         Kyh4ipjW17sVYvKZvkeqpsAqE45gI5G6QLzTk2WqZsjRhqayg1wvcD5uz2tNJG9oUgAH
         XjdrF6xrteKeNJPeYgmsEdQ0+NHJDyKHowuv5qrB1PBH9hQqgmTAUyq3jKZ+NxSohGDM
         XdU/j/ZxbXxxD4lq4KRHGzKNeZLeUJrMuSs/NCc/j9Cdt7QIWmz/Zjc/skCart8FPAQe
         CFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUuBp7Up2TXX6d5boE58Fuw3mGz48ha2UT5mU3RpYjZIinO+hkdBDAnbzaTalupcQ4PUIPGKaSkeJCgoQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFpD9wgpO2mW7T7ntLFWRGo7+crlT5A1o3rOrV0vrgxkAAwMe
	Dop+6aDzgaxQPMGG57KHoSU2haych6cFoMPPPAimc6br783YVCbXuXRegIi6IO2tNbdz1pP4ufB
	k1Nkz8h3IoYio4Q0k0mh9Ioo9ZwrclQyb6z08HdnKSbbm/kgZmNrmEvFKD9INClgmdw==
X-Gm-Gg: AZuq6aI90o0a1h/OIEVO2fdthZvrNC3QEbTE3M/x1TCEE2FOX+N6v8K83ZIdKkZnl19
	fCLNu+trQBTt2iCsV7AXharic/wH1NgVmmf7KHOhNRDV44Wf97QM3vqyby5pL3dvahxx0GCofPh
	/kPJKA414+TcqZfpospwNbeUyzURWqMfpqzUV+jId9ho884ACgY15yu5NxA+e44SVANyYxiI+i2
	cumVXsYW5pJpPlVLLRGlhNLuYMo39OATAgqJjmG4Ljgdw/sV7VUiB6SBTV8M9bEYgPCCT6ghaoS
	VPLj+U6rMXmY1AbsOqAlHu/hCZkSiNQsurdpbKrnuv+5iIUzTMgYexSOMRWeEBof5Au53NzutC4
	Lt+zcquleq70=
X-Received: by 2002:a05:600c:3e0c:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-48398a65ecdmr21410075e9.2.1771407791621;
        Wed, 18 Feb 2026 01:43:11 -0800 (PST)
X-Received: by 2002:a05:600c:3e0c:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-48398a65ecdmr21409665e9.2.1771407791053;
        Wed, 18 Feb 2026 01:43:11 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm40263806f8f.22.2026.02.18.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:43:10 -0800 (PST)
Date: Wed, 18 Feb 2026 10:42:40 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 13/35] xfs: use folio host instead of file struct
Message-ID: <jvxkaf73yuudonjcu2uoazt6yq33ievjo3js43lh4amrwrb5gq@7sj7zzcv2jfl>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-14-aalbersh@kernel.org>
 <20260218063234.GA8600@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218063234.GA8600@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77548-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC510154D02
X-Rspamd-Action: no action

On 2026-02-18 07:32:34, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 12:19:13AM +0100, Andrey Albershteyn wrote:
> > fsverity will not have file struct in ioend context
> > (fsverity_verify_bio() path). This will cause null pointer dereference
> > here.
> 
> FYI, I've included this and some cosmetic cleanups in the just posted
> updated PI series.
> 

aha, thanks, I will drop this one then

-- 
- Andrey


