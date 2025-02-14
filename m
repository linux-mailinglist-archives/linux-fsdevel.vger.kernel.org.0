Return-Path: <linux-fsdevel+bounces-41741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FFCA364AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EB23AC6E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D088267AE8;
	Fri, 14 Feb 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="O9NUoTtI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BCFEcw05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17386328
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554573; cv=none; b=CLss85B1BZiQakdqvCAQilS//v5Kk05ekhdET18NsL4cbYBbtNf9om6mattzFQK4PXdES4sIUnXSrWF2vQNigig9Nlcmec3nYasg3kzCGkaHVf7RGvYbb1oxdAM/atzX3caZ5NoVEicWPfzgKBjwkJLTle6K9M6naIV6OyA7r3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554573; c=relaxed/simple;
	bh=hfMuZxhIDEwgl++mhACcsoC9ZkgvrBSEjw/gwXAnYqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUKb7EpXVMZbBUWCTmS+su3Jit3vMa6JR8vKh+xgE7B+ZSGZ74/+LS9k9BqtASqbfCvEQemaAKWaOhhHpgEmB+2GuZqOaHSQwSd9TZ81YCCWq337jAafvxrIS1k0WVVVZQgei75yHw0sT+noiOg163u/ERtMEWs/gASGwNYWyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=O9NUoTtI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BCFEcw05; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 26BF9138017E;
	Fri, 14 Feb 2025 12:36:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 14 Feb 2025 12:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739554570;
	 x=1739640970; bh=Xy9onQhJpWDnRRTzlDR0xQ4hkJ+o5s1BtGCS8R/cStg=; b=
	O9NUoTtIUdTUM18Rr7ml3IoLRZu4Cv793VpncCAm8vlINvEBCBW/iJDkcc8s3Sel
	uMm5Hngnj9WWcAqSKagMkzXDH7mzMWSjpBS7Kv+n8LKIeONMoAIp6YYsfe+P959Q
	+bF71ADg4q87P5AQfTkGHLwo3j71Rbnj+EVSoj5mM1/wdmuz+rFdaKGZ5fOYQQxU
	ji6jfELXOJQaUxP+KEfoo4bqNRroJ8V5QTCuSBf3a2L6TT2J1Lv+Z8MWACRVMrLF
	27yFK3rfquumDe3a3wTAnOnmNDi2qtrJVLxyOfTCil7kIVenauI14rplsxGTEOzu
	czJjvNFdLzIvtasMyJ9tiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739554570; x=
	1739640970; bh=Xy9onQhJpWDnRRTzlDR0xQ4hkJ+o5s1BtGCS8R/cStg=; b=B
	CFEcw05XndBr7m3r9mfWggOY+s3L8MkVakRrwkBN25OShBsnQPbnxzjrCerZDEnk
	QERVmjCqfz2da7AdNyIBODERbvqwU3WkjH83hObiN5W/B8d7V9Czc6eBMjblMiTW
	JTG0rt8AfsV4BlT0gTTgjQInbhD4u9IpAt1PXdxPlE9dmsdk+l5D10kKQj6dkI6X
	qOpZ+emBcUAh799gw6x1YHuowbyPgG0S+XbQ0JD3uS2m/IQJNfXSfRn+1Ke8EVeF
	D5lIHPjH3VxO8n/B0+oAEuqMYGf3jtoCNfsZxisPdC3v4P0WplEgbhWwiSNbv2YG
	8+JDpPneEqgRedsWNN2vQ==
X-ME-Sender: <xms:CX-vZ_v5mjQ_QYLG3QOLMh6KavePTK5ujeQRrHyxek_Byz1UQhwUbQ>
    <xme:CX-vZwcO7gcViJkJgHRfYxaYOyGcybDRmzwaGDadRee08l8XJwc2thM4m_BZEZ2gL
    veCcvf2KX4K5d3VX5c>
X-ME-Received: <xmr:CX-vZyybyjhCM7BRnyqjlL67N0qRla8KkOiVXbNeXGH8bHSmcfJ5RYmIBaX2-HXuc-igSGZ5OvoXs2_gM2pOdxl68DXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegffei
    vdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughhohifvg
    hllhhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshesshgthhgruhgvrhdruggvvh
X-ME-Proxy: <xmx:CX-vZ-MFIa8A3oeXbEH4PDHEfOKVQTnpCkTvWen_G0YAJS5jkOgisg>
    <xmx:CX-vZ_834b98QYoGXrOKoCdIeAsVAv36bkjOaZa1YEaCqK6IaIVJcg>
    <xmx:CX-vZ-WNLk3Bz7Rln4PTKFmB-Gkf0P75c75MxtcAAvLKEUk4zfGdlQ>
    <xmx:CX-vZwe6B4jmjqlJwhtsYycUdT2LZKUjz5-eKsAWjTj3VBJ1tIUGow>
    <xmx:Cn-vZ7bifeZlZAOw-zC4bKKK_QBGP9qmi-cutnKs8AAdx35DIPbtpKEj>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 12:36:09 -0500 (EST)
Message-ID: <9dd45f32-e8a5-42bc-a9d7-d6dd9e351eea@sandeen.net>
Date: Fri, 14 Feb 2025 11:36:08 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] watch_queue: Fix pipe accounting
To: David Howells <dhowells@redhat.com>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Lukas Schauer <lukas@schauer.dev>
References: <a8d8f11a-0fea-4b74-893b-905d6ef841e6@redhat.com>
 <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
 <4145092.1739551762@warthog.procyon.org.uk>
 <0a3f44cb-46f1-4ffe-ba8e-ce7f0cee1bc1@sandeen.net>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <0a3f44cb-46f1-4ffe-ba8e-ce7f0cee1bc1@sandeen.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 10:58 AM, Eric Sandeen wrote:
> On 2/14/25 10:49 AM, David Howells wrote:
>> Eric Sandeen <sandeen@redhat.com> wrote:
>>
>>> -	if (!pipe_has_watch_queue(pipe)) {
>>> -		pipe->max_usage = nr_slots;
>>> -		pipe->nr_accounted = nr_slots;
>>> -	}
>>> +	pipe->max_usage = nr_slots;
>>> +	pipe->nr_accounted = nr_slots;
>>
>> Hmmm...   The pipe ring is supposed to have some spare capacity when used as a
>> watch queue so that you can bung at least a few messages into it.
> 
> If the pipe has an original number of buffers on it, and
> then watch_queue_set_size adjusts that number - where does
> the spare capacity come from? Who adds it / where?

If that was resizing the ring to nr_notes not nr_pages, then ... I guess we
could keep the pipe_has_watch_queue() test as above, skip updating nr_accounted
there, and set it manually to the user-charged number in watch_queue_set_size()?

Something like this? I'm not sure about max_usage, maybe it should be set
as well.

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 5267adeaa403..07a161ecc8a8 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -269,6 +269,14 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
+	/*
+	 * pipe_resize_ring does not update nr_accounted for watch_queue pipes,
+	 * because the above vastly overprovisions. Set nr_accounted on
+	 * this pipe to the number that was charged to the user above
+	 * here manually.
+	 */
+	pipe->nr_accounted = nr_pages;
+
 	ret = -ENOMEM;
 	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)




> Thanks,
> -Eric
> 
>> David
>>
>>
> 
> 


