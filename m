Return-Path: <linux-fsdevel+bounces-75344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNeoMdROdGnx4QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 05:47:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C997C825
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 05:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30EB53001FF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3836314B7D;
	Sat, 24 Jan 2026 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IY7wblTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72E5478D
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769230033; cv=none; b=foeDRkDdxe2RzC4fX+6jaWruC2dstutSQtY4P2uReJSOq/DUHb5qLEsIqWNMOEB2VtLn7GbGuzuPotkUOFRQ1JOngENEPgSJIbg9NlaobAgUGUUdgy8EqYhnQUkyPxACneKIa/RURZ4E4YZIE1c3WWoadTExjQYEQysi3NLq+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769230033; c=relaxed/simple;
	bh=CB5J02T+5IO73ueNX2CaPuvQKzf2KrFYhwpG18psYPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYWw5u3GLREXkrH2HJbddrVlNxoRSr4nNteWk8rnHztam7OMoDy60oSrwk5Kg4RWkdAoY/osTPseALtxWVQbDMrHz0PLO6XCXnnwFMR6fzFcYs/jKi93/0LduKl8tanTgTsfMr2diW9CsQh58moRsUb+MSTfizhi4MJtd3Re3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IY7wblTz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b884d5c787bso463425066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 20:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769230029; x=1769834829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+nMsUclCeFqeCTuBleXi41ze9QH7rAmgfac2T8peZ4=;
        b=IY7wblTzQx5LEAddOOMLAwlQVRcNeCx5bGadMHVE8Gd10VVluAwXlS5pTkcVxfehNl
         LzhufQnEyT4vjW8Ip62P2SUNk/b1HMXO9dsP5ijC7gsUP96AAYBiDHIboZ8litr4WY4S
         y220Svp3X0eCpRkULPmQvjRb4M0z3vJXGNqFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769230029; x=1769834829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+nMsUclCeFqeCTuBleXi41ze9QH7rAmgfac2T8peZ4=;
        b=ClIn37zfBXmyQcWzwGLfIC8mxn9aF2k+uAIZ+TT6D9BsvpneihZYrggd0krw7NJqP9
         onoGxNEJVAsEEShh9zLW7dEKMEve7UKZnrOcK6MAGy2IaAg8jVVj2MHAr7/ira7ZkKoC
         L9umx9gVCeNzYvrX5HiZyeLNORd4xbfzwPQsFnqf/QTX1Qx2b8gye4pDY0faqzqHvV5r
         1jNfhX2ePkw+x84yyW8m7TM+BRpoKGqFSIPsEqXnLNT9D0QPPZmD+au+G+TFTb284bfS
         rTEC9tjvXHqyBO1kXBoWRNLkPBr+n+XJ+tqkUK/6wLxChinb9oBGOPBnD0wN6EX5igPR
         zfKA==
X-Gm-Message-State: AOJu0YyRNB6X3jMwt1HNuvMNlWV3mz5FKg6w2hZq4UMyDdLR90hN7vN2
	EQUsTU5/ndB1ATQlWY7blKSDNtCPUzm0TGvBulZQc82mQzzaECJZqdEI5jL55hGISY07Q7+nbw+
	s8cLJFac=
X-Gm-Gg: AZuq6aLbF7i+MIJAboQY5CTwl+ZOJN6WiZ/veDMInZUiWiVEwle6xyzCkbARP+f9Xhj
	uRyX+bgi57f7Cwv7cYLzPKfI/DkFBNshj+00oBT4WxVYLimjSbiT6wzru5GpCU9JXaBYv9X8tp8
	mdh+4mj3NQnBu2F0+OyiGYvJOzQtL0BEMrrT/cU8X5e9qeC7CbgLaLujWKzfB3C/KYgBIDaezWc
	lcpPGKmvF8lei7Wc1YqyySDnKaRfeJqT08BNLpzyPkklyylstiWEPPol5CkKB9qzGZa0j4h3Nrn
	LlysyD4X14+nqlxB13ImVnS3xzS5nIG5ac79j23bgqJGI01pxKSsAjmcM5UfA6nm6N4+aj6HW69
	bmLJx1my+gfCxCkFH1ahf0rJ4yuUkaHk7rdXNpJ2sYEG6zpdUSmIjpgFcDDJRm22wK7FiC0RjYd
	NwLOeTjYRNcm5KcYGljEy+SGtFwjbVMys4o6jjDGAcqs58XDzh9WnxK8BFrs3F
X-Received: by 2002:a17:907:3f90:b0:b88:505d:2a2 with SMTP id a640c23a62f3a-b885aba504fmr356591666b.9.1769230028991;
        Fri, 23 Jan 2026 20:47:08 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b77806esm205027966b.56.2026.01.23.20.47.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 20:47:08 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso130345266b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 20:47:08 -0800 (PST)
X-Received: by 2002:a17:906:c113:b0:b80:4108:f826 with SMTP id
 a640c23a62f3a-b885ad28db3mr356970966b.36.1769230028184; Fri, 23 Jan 2026
 20:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
 <20260123003651.GH3183987@ZenIV> <20260124043623.GK3183987@ZenIV>
In-Reply-To: <20260124043623.GK3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Jan 2026 20:46:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com>
X-Gm-Features: AZwV_QgjO_qjcAH-g28DR5IjY80Xzclf_kjgpuMARBMx8RThAfSE-UoRPO8V6qs
Message-ID: <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75344-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,linux-foundation.org:dkim,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28C997C825
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 20:34, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> >
> > In practice it doesn't really matter, but we don't want to initialize
> > that field to NULL - no good place for doing that.  Sure, the entire
> > d_alias has been subject to hlist_del_init() or INIT_HLIST_NODE(), so
> > any pointer field unioned with it will end up being NULL without
> > any assignments to it, but...  ugh.  "We have a union of two-pointer
> > struct, a pointer and some other stuff; we'd set both members of that
> > struct member to NULL and count upon the pointer member of union
> > having been zeroed by that" leaves a bad taste.
>
> FWIW, there's another reason, but it's not one I'm fond of.  There are few
> places where we use hlist_unhashed(&dentry->d_u.d_alias) as a debugging
> check.  I _think_ that none of those are reachable for dentries in that state,
> but then all of them are of "it should evaluate true unless we have a kernel
> bug" kind.
>
Note that I'm not complaining about re-using the
'dentry->d_u.d_alias.next' field.

I'm complaining about re-using it WITH A CAST, AND WITHOUT DOCUMENTING
IT IN THE TYPE DECLARATION.

So by all means use that field, and use that value, but use it *BY*
making it a proper union member, and by documenting the lifetime
change of that union member.

None of this "randomly cast a different pointer to 'void *' where it
will then be implicitly cast to to 'struct select_data *'" garbage.

Just make a proper "struct select_data *" union member that aliases
that "d_alias.next" field, and the compiler will generate the EXACT
same code, except the source code will be cleaner, and you won't need
any hacky pointer casts.

And document how that field is NULL when the dentry is killed, and how
that NULL 'dentry->d_u.d_alias.next' field at that point becomes a
NULL 'dentry->d_u.d_select_data' field.

You don't need to describe 'struct select_data', you just need to
declare it. IOW, something like this:

  --- a/include/linux/dcache.h
  +++ b/include/linux/dcache.h
  @@ -89,6 +89,11 @@ union shortname_store {
   #define d_lock       d_lockref.lock
   #define d_iname d_shortname.string

  +// The d_alias list becomes a 'struct select_data' pointer when
  +// the dentry is killed (so the NULL d_alias.next pointer becomes
  +// a NULL 'struct select_data *'
  +struct select_data;
  +
   struct dentry {
        /* RCU lookup touched fields */
        unsigned int d_flags;           /* protected by d_lock */
  @@ -128,6 +133,7 @@ struct dentry {
                struct hlist_node d_alias;      /* inode alias list */
                struct hlist_bl_node d_in_lookup_hash;  /* only for
in-lookup ones */
                struct rcu_head d_rcu;
  +             struct select_data *d_select_data; /* only for killed
dentries */
        } d_u;
   };

but I obviously didn't test it.

            Linus

