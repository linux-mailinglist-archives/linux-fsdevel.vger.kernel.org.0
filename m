Return-Path: <linux-fsdevel+bounces-75584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFciNUdeeGlwpgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:42:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5126C907B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA2D03047BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99829DB65;
	Tue, 27 Jan 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hog9zkiw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01513329E44
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496097; cv=pass; b=r77y3Jm7tvXaiqiKrlMrZSSsbarvxh6qFOvILllTuOnPs0JferNH3ZOnH/yiaV/pPj14OpiWaahk2ss94TwJWl19y1P7XpzH9O+Ojnk3PeQxKXE3QZDn6kLNJVRvbSyzLRJW9RB7+JNg2yJXl5fbY5hVsEwSCbG3vdBVP5jxlv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496097; c=relaxed/simple;
	bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI99JYXZDrQyUEkkwUtVbQmSorvcVAE6Ot2+iNqO+WnOBQZRd47tFxP6M1MyN2l900t1KFgLsEnm9QaWy/tmSpvovxURVGdfQJPz+qPMdNzbs/Wwa2xZDvdXoplH5sAvW28do0WSWphu6lnL1udZi2k/zQoigwruDHaesLKfg/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hog9zkiw; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c56188aef06so2153098a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 22:41:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769496095; cv=none;
        d=google.com; s=arc-20240605;
        b=bXLi9PaG7fcPtU+aov4+COIjI4T5tD0jFAMv3I7Z0qSGHf+Rv/RBnegHMi8J9UodTK
         I4EGOsTF3E1cqesK4D4f3rxtXHhdKpfvVBVE8HO762/U2DiEgLIgcyoLXWoxObXPjPUR
         h3Px0TcM1/4OVl0MITAVyRlQ+zqAyOIQY+DquDzLmJDIAZL4sekyHfvlj//mkRrKF/44
         ZTsAfucpqnVeBg4z2tQJ2cso2WdLJWlrzP1OVQgmf325wjkO9wqPP+3upyzgE6CECOws
         liuzQ1NF9+JRfd3sCZyftQe4YxD+iZgz0MSWjjP4mjsPjFGuFFcccZQOUy/bbwDsuw5t
         hmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        fh=I35A+GkSghz+GKvbQLWMZMDqd5DQlDweiGbvqx5Ntcc=;
        b=azmYNZzlpvgYV6DdTFcOndebFVM30YR9aJzYQoof85HdInLzRezc8VLMcMTqld7Sa8
         XL4d3bfiZit1pvqNQKYgzu5DlQ/UHTDOXTAt4Hx4ozXxDnxKFvp6yzh5SvGmtdTn6xBO
         n8g3IEIoan2llTxE5uBZXl62Y1Ws/eWGgnt9WqfsVu7VDRM2s5QL2h+PBSZUWYnfaxS6
         evcgnKkx0zJsKIHzHsRfwi3F7ap7gGYwd/IffP0YJXEJywagM/zmU/aQFIQnTr2Ss0Yf
         OpXSSAwQdlornZHb12nsjLuwo4DmuKYxVL9y91K8gRpT5q5pU9+r/SExcZG68Q6ajtha
         j0EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769496095; x=1770100895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=hog9zkiwrrJlk9Nyncvxy8/ASd14ErELqSfiWxJL/7gE6+vSmfo74znymWlx+goXyc
         sakbIaYLVBYhjbDwN3/iy98Uke1NuR/DDk2qo4ipaFUt2EgbkHtDzgk+PDPN9WrSUhgO
         IoED3yzteI+BudoKZ/eiHt2828jTA1wdP0t4toVJLAfNRNSnkPGscnzN+VVcp7jfBgwm
         9soo3L5pVFhZVWbW08ccbXz6IpTLKJmvRUs4Z1CA2jJAS5aWgzsv/ZV1tKZ8kEDJSGW5
         heKeNZrXj2Ixuc/Ws17SQx7MpxRcOD2HplGu+k7sRMQZ8SRjpShe1R3iYqG5JCY8Ebbg
         ylSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496095; x=1770100895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMiOIo0AEhI+Ah5+oKBr97SiEAtqyx7d+chKwMjJfFg=;
        b=ha3K/n+6SWz6Ay5Ivetwp9BgE9L7JMG83RKDZ64tpWypp1Km/NZv7DNdV2CmuO3QJO
         c/HJGeI+fmPD/kbifF9+/Jhh3EYXxFmaKVI9Oo+IwmsbkATn5F7qmXc2lEarTk6xxbyX
         BUjbQlKodEkjWPobRCUCBHE/GV4EbVMWG+r6sss8WptqW+VvbRtUWXcpaZ/G5SI4nzT8
         atX/gLXF9tpJ2Ezn6qKZwl+WZBJSSiZaRxegCGWGNraMb9C57tBVS/JgaIdfGoGE0q4S
         97dkHcFLtHz8SRUycpPuu0Tfsm4Tu4hyHagIug6/KvXMaQIsiEdQduU8qdQSaHhgz/j1
         pGGQ==
X-Gm-Message-State: AOJu0YzYy6QnZLuVgU6EfaP1OUGN2BEg0ejeaDz4Wg8S1CgivjCRnBII
	8tVImGq/1Bc2esPYTacfQ5sYfeAzQfs7AZglBfR2AfYXxUXWDhcE9o78iBR/LTiV5zqld5gwmch
	Av0QihiocQg/U+XyzGZwIORueDsZfHgrAxHIyW5CL2A==
X-Gm-Gg: AZuq6aJq5l5GChNBHE2dJygbmU3JwAKgdv+B+EqCQxwaNrpfkhLJIjQWLq7SGm2EPmm
	alZKfC4lAqamrma2wbKzUdj+RNfPWOPLsDTr4OLkPRDlNgw3FF59YPr8dGrqQkLItaqqexsNG2U
	sYLTPLanylBkZ3bATHD2M/vEa09ZY0LBL+bmOlgLgnsGnSNyXtBqJWkXXA0P+rrTEPchMk1axWy
	IB4/mp2ellegKxTq8Ypk55dhtm4rsEH4mXas/NmOx3Hi6VlUbck5EemJlz3ai8fTgHm0ULnXxDy
	jUgnKPbLj1K06FSo1p14rn0=
X-Received: by 2002:a17:90b:37ce:b0:34a:b8e0:dd64 with SMTP id
 98e67ed59e1d1-353fecc66e8mr838783a91.1.1769496095413; Mon, 26 Jan 2026
 22:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4dvsfs55KqSNmdv_LM1_4moUUcVxvjCrj5zjGFxOH4mi8xOQ@mail.gmail.com>
In-Reply-To: <CAP4dvsfs55KqSNmdv_LM1_4moUUcVxvjCrj5zjGFxOH4mi8xOQ@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Tue, 27 Jan 2026 14:41:24 +0800
X-Gm-Features: AZwV_Qj8stZNqTeDVmt9mJzuZzs-CzyGmrAdTNRbKOsFDUdFKR3JwDxmqXSJ9kY
Message-ID: <CAP4dvscmAWgQ2CXJ_O=JuH2GMM09nq+w7hnfQsMJdaXDMk+qCw@mail.gmail.com>
Subject: Re: [QUESTION] fuse: why invalidate all page cache in truncate()
To: miklos <miklos@szeredi.hu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75584-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:dkim]
X-Rspamd-Queue-Id: 5126C907B9
X-Rspamd-Action: no action

gently ping...

