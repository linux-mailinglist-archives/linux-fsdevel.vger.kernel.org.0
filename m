Return-Path: <linux-fsdevel+bounces-79335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAgjDjQFqGkRnQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:11:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C84291FE22A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 11:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 239563013A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5339769D;
	Wed,  4 Mar 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bQISO49u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yz+9ve/n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bQISO49u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yz+9ve/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA03389113
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619050; cv=none; b=HaoR7QEywuG7VClLj7GF23grUrYjwPqnF/giD8dDf+VSbEJAc5ilffYtoSiNf++M/2O/NUiRHWr3nd2LD59smoKtJtFMZuqG1k5ksZoEhdnHZp/3hG6saQkErF21/x1cmt2DUe1Y9BtLNLk/h5h4Tjv8Q0392ghwdytgFgkzDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619050; c=relaxed/simple;
	bh=nCj61CizqZiEg+f7MtQHHwlwPtcq/rqtYaq2qEOP5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1IkYM6aIg8DyDIf3IgpI+7EbmUWwlt/T3prucOyn/YczsQKz2gy6NieAIBEYXM68rpGJJB+p0c9USZLVbiZYhbXMyOvX9Z7CQjkw2nHxk+RMTcmHnW1MKKN6+e9iQYJfk31W3IolN3p6gyjsSQziwpT1UBRpLoZ0wYlKdbcX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bQISO49u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yz+9ve/n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bQISO49u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yz+9ve/n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1E25BDA8;
	Wed,  4 Mar 2026 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772619047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4MIYmwFApZcbH8XmHq5Ir9R9Xf87Q5jbCIodmxKoxw=;
	b=bQISO49u9vYqTIRiQdLqG7+H7Zre2VhJ+OgifW4Oz3vUQWPhsxdF2T8eHOzJR+rlFlDHJg
	RycCmJyY07HcpCBhVbRhXAp+EMJby5mYOEqxSs4i7M4Jcl7azvdL0E1AFOXgJxO/t5qxBl
	wEZk6bgYkdO217Db6MbYMjwXLJ29Nyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772619047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4MIYmwFApZcbH8XmHq5Ir9R9Xf87Q5jbCIodmxKoxw=;
	b=Yz+9ve/nZuhu3ySSWtz3Qjss8KAhWzAojUXoD9ScgfAIqTmW/+x4JzNimR5fzA/bP6mvo/
	Q0oR+UI+Qbs51hCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bQISO49u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Yz+9ve/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772619047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4MIYmwFApZcbH8XmHq5Ir9R9Xf87Q5jbCIodmxKoxw=;
	b=bQISO49u9vYqTIRiQdLqG7+H7Zre2VhJ+OgifW4Oz3vUQWPhsxdF2T8eHOzJR+rlFlDHJg
	RycCmJyY07HcpCBhVbRhXAp+EMJby5mYOEqxSs4i7M4Jcl7azvdL0E1AFOXgJxO/t5qxBl
	wEZk6bgYkdO217Db6MbYMjwXLJ29Nyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772619047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4MIYmwFApZcbH8XmHq5Ir9R9Xf87Q5jbCIodmxKoxw=;
	b=Yz+9ve/nZuhu3ySSWtz3Qjss8KAhWzAojUXoD9ScgfAIqTmW/+x4JzNimR5fzA/bP6mvo/
	Q0oR+UI+Qbs51hCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F5623EA69;
	Wed,  4 Mar 2026 10:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZDK5AycFqGn+eAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Mar 2026 10:10:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7FC0A0A1B; Wed,  4 Mar 2026 11:10:46 +0100 (CET)
Date: Wed, 4 Mar 2026 11:10:46 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	gabriel@krisman.be, jack@suse.cz, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
Message-ID: <6igt75nncormn6homqfeu6qj23vmzfhhf3eoprfkuexldg6xa2@xexics5uz52p>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
 <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
 <CAOQ4uxgmYNWCs18+WU9-7QDkhp0f_xX6nvKiyDhS8gZzfUXXXA@mail.gmail.com>
 <aab1Z7J-m97VfFvS@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aab1Z7J-m97VfFvS@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C84291FE22A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com,vger.kernel.org,lst.de,krisman.be,suse.cz];
	TAGGED_FROM(0.00)[bounces-79335-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 03-03-26 06:51:19, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 10:21:04AM +0100, Amir Goldstein wrote:
> > On Tue, Mar 3, 2026 at 1:40 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Test the fsnotify filesystem error reporting.
> > 
> > For the record, I feel that I need to say to all the people whom we pushed back
> > on fanotify tests in fstests until there was a good enough reason to do so,
> > that this seems like a good reason to do so ;)
> 
> Who pushed backed on that?  Because IMHO hiding stuff in ltp is a sure
> way it doesn't get exercisesd regularly?

Amir wrote it well, I'd just add the 0-day runs LTP, distro people run LTP
and lot of other test bots also run LTP so I wouldn't say fsnotify tests
are not exercised regularly. For record I don't expect regular filesystem
developers to need to run fsnotify tests as the code is generally well
separated from individual filesystems. Filesystem error reporting is kind
of special in this regard so I agree having it in fstests makes sense.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

