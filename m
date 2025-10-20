Return-Path: <linux-fsdevel+bounces-64710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFEBF1BF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 924194F6CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610F3176E7;
	Mon, 20 Oct 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdzaI8rU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C221FC7C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969316; cv=none; b=Z7tGFoscu5LIWANXfOckfwbwI5qQVetPCQ93imkFELyi1u+gqodc369gs/axOrJOKVGZ7q/JksbZuoOVAPRHd6Mbngyy5QJWGc7iddakjCI9sI/aFi80AwsM28aHo8cGeQk9mtHlHiCqdmYRWAxt859oga09E8glqpzbDYer2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969316; c=relaxed/simple;
	bh=pcctocOkzBUdEtmKXW1xvGeZn5knFljr8dfDxFVUCcU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bp6TMzDrIFmfv11oWlqg7Mjk31TTmi55metTxGGb5b8PFDJTZCIVJZFnPv8txSQmPVxaTb08EEYmWqECz4dfYTa7paF0lCU64cFv7AZViv9gtrhLI+D/TzM1a0Z9+nCIaqLH+tmTSrecSefnu1AytfeAe4mMdWsuZ3cS4cYN1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdzaI8rU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcctocOkzBUdEtmKXW1xvGeZn5knFljr8dfDxFVUCcU=;
	b=bdzaI8rU9A4Urd/bTUqWGgktum1PbYbI0U0WXkFuKLFGssR2Xid6sWx1KNqtFb2f5mD7+C
	re+AqBXtyG+WeVoUzN74Pwy6//FAgM6CfTiuAB2EXm3bE60cxQagiUve4SEz1gZ52nUFpg
	AqS3XacgSVcjMF0xouTLegSHf9N2kPA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-zQ9TuPahPf60jid3hBfowg-1; Mon,
 20 Oct 2025 10:08:30 -0400
X-MC-Unique: zQ9TuPahPf60jid3hBfowg-1
X-Mimecast-MFC-AGG-ID: zQ9TuPahPf60jid3hBfowg_1760969309
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F39E8195422B;
	Mon, 20 Oct 2025 14:08:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C97A18003FC;
	Mon, 20 Oct 2025 14:08:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <vmbhu5djhw2fovzwpa6dptuthwocmjc5oh6vsi4aolodstmqix@4jv64tzfe3qp>
References: <vmbhu5djhw2fovzwpa6dptuthwocmjc5oh6vsi4aolodstmqix@4jv64tzfe3qp> <1006942.1760950016@warthog.procyon.org.uk>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix TCP_Server_Info::credits to be signed
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1158746.1760969305.1@warthog.procyon.org.uk>
Date: Mon, 20 Oct 2025 15:08:26 +0100
Message-ID: <1158747.1760969306@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Enzo Matsumiya <ematsumiya@suse.de> wrote:

> Both semantically and technically, credits shouldn't go negative.
> Shouldn't those other fields/functions become unsigned instead?

That's really a question for Steve, but it makes it easier to handle
underflow, and I'm guessing that the maximum credits isn't likely to exceed
2G.

David


