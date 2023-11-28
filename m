Return-Path: <linux-fsdevel+bounces-4039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E17FBCB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7102D282E69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1585AB9D;
	Tue, 28 Nov 2023 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB9718D;
	Tue, 28 Nov 2023 06:28:58 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D179521995;
	Tue, 28 Nov 2023 14:28:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F5D313763;
	Tue, 28 Nov 2023 14:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OByqIij5ZWW3PQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 14:28:56 +0000
Date: Tue, 28 Nov 2023 15:28:55 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tj@kernel.org, ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 02/11] mm/mempolicy: swap cond reference counting
 logic in do_get_mempolicy
Message-ID: <ZWX5J5frMXCnO1HW@tiehlicka>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122211200.31620-3-gregory.price@memverge.com>
 <ZWX0Dq6_-0NAFgSl@tiehlicka>
 <ZWX0ytAwmOdooHdZ@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWX0ytAwmOdooHdZ@memverge.com>
X-Spamd-Bar: +++++++++++++++
X-Spam-Score: 15.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: D179521995
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.82)[-0.820];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.18)[-0.923];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.14%]
X-Spam: Yes

[restoring the CC list, I supect you didn't want this to be a private
discussion]

On Tue 28-11-23 09:10:18, Gregory Price wrote:
> On Tue, Nov 28, 2023 at 03:07:10PM +0100, Michal Hocko wrote:
> > On Wed 22-11-23 16:11:51, Gregory Price wrote:
> > [...]
> > > @@ -982,11 +991,11 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
> > >  	}
> > >  
> > >   out:
> > > -	mpol_cond_put(pol);
> > > +	mpol_put(pol);
> > >  	if (vma)
> > >  		mmap_read_unlock(mm);
> > >  	if (pol_refcount)
> > > -		mpol_put(pol_refcount);
> > > +		mpol_cond_put(pol_refcount);
> > 
> > Maybe I am just misreading the patch but pol_refcount should be always
> > NULL with this patch
> > 
> 
> earlier:
> 
> +               pol = pol_refcount = __get_vma_policy(vma, addr, &ilx);
> 
> i can split this into two lines if preferred.
> 
> If addr is not set, then yes pol_refcount is always null.

My bad, missed that. Making that two lines would be easier to read but
nothing I would insist on of course.

-- 
Michal Hocko
SUSE Labs

