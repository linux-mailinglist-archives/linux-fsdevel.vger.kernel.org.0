Return-Path: <linux-fsdevel+bounces-6525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE1819211
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 22:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835A01F217E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C23AC01;
	Tue, 19 Dec 2023 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hp/CB7sd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46E3A262;
	Tue, 19 Dec 2023 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=h10GokaO9AbOHGo8bR1eL3FJfOAuP7hDq2UbXI6mgtQ=; b=Hp/CB7sdtsS33xpvxcRKaIgbZV
	YbS6Ad+RcDCJM6liTHW+kWam+5VvbWdE6ZnUod326jBH2hksBaV3vVPzCzdAGs74Pywy2yW6Jj0Y6
	DDz7yT4U9pMuIdbDE5l4zyscArpl3exeIMnezuRZ2z2/NeQHJzhtWAce9oHTUweqjVSqywSee9HZU
	/rc8Ai9DWYC2EyetD7MYzXe1UHY5/2S0dO+evSlVWryDe2HPr2+9cIWWV6uBV9022npAsVBxcfvA0
	tYmvabfW44u2gd98xMT4dCCDXerIkLZZC7YPPOelAmZbddcNVKQVHRuBATCOd4JuuQwtvndIHbzLL
	rC+2v/8g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFhLH-00FTPf-0N;
	Tue, 19 Dec 2023 21:09:31 +0000
Date: Tue, 19 Dec 2023 13:09:31 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Joel Granados <j.granados@samsung.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZYIGi9Gf7oVI7ksf@bombadil.infradead.org>
References: <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
 <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
 <20231217120201.z4gr3ksjd4ai2nlk@localhost>
 <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
 <ZYC37Vco1p4vD8ji@bombadil.infradead.org>
 <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Dec 19, 2023 at 08:29:50PM +0100, Thomas Weißschuh wrote:
> 
> I used the following coccinelle script to find more handlers that I
> missed before:
> 
> virtual patch
> virtual context
> virtual report
> 
> @@
> identifier func;
> identifier ctl;
> identifier write;
> identifier buffer;
> identifier lenp;
> identifier ppos;
> type loff_t;
> @@
> 
> int func(
> - struct ctl_table *ctl,
> + const struct ctl_table *ctl,
>   int write, void *buffer, size_t *lenp, loff_t *ppos) { ... }

I think it would be useful to describe that the reason why you have
the parameters in places as required is you want to limit the scope
to the sysctl handler routines only, and these have these fixed
arguments.

make coccicheck MODE=patch COCCI=sysctl-const.cocci SPFLAGS="--in-place" > /dev/null
git diff --stat | tail -1
 80 files changed, 390 insertions(+), 306 deletions(-)
git diff --stat | sha1sum 
 ec90851ba02dad069b11822782c74665a01142db  -

> It did not find any additional occurrences while it was able to match
> the existing changes.

Fantastic, then please use and include the coccinelle rule to express
that this is the goal, it is easier to review *one* cocinelle rule
with intent rather than tons of changes.

> After that I manually reviewed all handlers that they are not modifying
> their table argument, which they don't.
> 
> Should we do more?

Now that we started to think about *what* is the goal, and trying to
break it down it is easier to think about the ramifications of what we
need checked and how tools can help.

We break down the first goal into a simple grammatical expression listed
above, we want to constify the proc hanlders use of the struct ctl_table.

Given this, I think that for the first part the coccinelle grammar above
should take care of the cases where the compiler would not have caught
a few builds where your config was not testing the compiler build. Now
could this still allow

ctl->foo = bar ?

I think so, so here is a simple sysctl-const-mod.cocci which can be
used in coccicheck patch mode as well instead of coccicheck context mode
as the context mode just produces a removal visually, and I prefer to see
the removals with git diff instead due to color syntax highlighting:

make coccicheck MODE=patch COCCI=sysctl-const-mod.cocci SPFLAGS="--in-place" > /dev/null
virtual patch
                                                                                                                                                                                              
@ r1 @                                                                                                                                                                                            
identifier func;
identifier ctl;
identifier write;
identifier buffer;
identifier lenp;
identifier ppos;
type loff_t;
@@                                                                                                                                                                                            

int func(
  struct ctl_table *ctl,
  int write, void *buffer, size_t *lenp, loff_t *ppos)
{ ... }

@ r2 depends on r1 @
struct ctl_table *ctl;
expression E1, E2;
@@

(
-	ctl->extra1 = E1;
|
-	ctl->extra2 = E1;
)


The git diff --stat:

arch/arm64/kernel/armv8_deprecated.c | 2 --
drivers/net/vrf.c                    | 3 ---
net/ipv4/devinet.c                   | 2 --
net/ipv4/route.c                     | 1 -
net/ipv6/addrconf.c                  | 2 --
net/ipv6/route.c                     | 1 -
net/mpls/af_mpls.c                   | 2 --
net/netfilter/ipvs/ip_vs_ctl.c       | 6 +-----
net/netfilter/nf_log.c               | 2 +-
net/sctp/sysctl.c                    | 5 -----
10 files changed, 2 insertions(+), 24 deletions(-)

So that needs review. And the OR could be expanded with more components
of the struct ctl_table

As I noted, I think this is a generically neat endeavor and so I think
it would be nice to shorthand *any* member of the struct. ctl->any.
Julia, is that possible?

The depends on is rather loose so I *think* this means the second rule
should only apply the rule on files which define handler. But that second
rule could perhaps be made as a long term generic goal without the first rule.

I first tried to attach the modification of the ctl table to the routine
itself with so only the caller is modified:

virtual patch
                                                                                                                                                                                              
@ r1 @                                                                                                                                                                                            
identifier func;
struct ctl_table *ctl;
identifier write;
identifier buffer;
identifier lenp;
identifier ppos;
type loff_t;
@@                                                                                                                                                                                            

int func(
  struct ctl_table *ctl,
  int write, void *buffer, size_t *lenp, loff_t *ppos)
{ ... }

@ r2 depends on r1 @
r1.ctl;
expression E1, E2;
@@

(
-	ctl->extra1 = E1;
|
-	ctl->extra2 = E1;
)

But that didn't work.

> > The template of the above endeavor seems useful not only to this use
> > case but to any place in the kernel where this previously has been done
> > before, and hence my suggestion that this seems like a sensible thing
> > to think over to see if we could generalize.
> 
> I'd like to split the series and submit the part up until and including
> the constification of arguments first and on its own.

The first part is the proc handlers.

If after that you generalize when its used in any routine as this:

virtual patch

@@                                                                                                                                                                                            
identifier func;                                                                                                                                                                              
identifier ctl;                                                                                                                                                                               
@@                                                                                                                                                                                            
                                                                                                                                                                                              
int func(...,
- struct ctl_table *ctl,
+ const struct ctl_table *ctl,
  ...) { ... }

You increase the required changes and scope. This does not handle the
case where two different tables are in the same routine arguments, but
that is a special case and could be hanlded through its own rule.

> It keeps the subsystem maintainers out of the discussion of the core
> sysctl changes.

We'll need to involve subsystem maintainers eventually to deal with
special cases which don't fit the goal we want to normalize to. I
suggest you think about the changes in grammatical expressions, leading
up to the final gaol, where we could do a full sweep and ensure no
struct ctl_table is not const.

That is, as you work your way up to the goal, I suspect you may need
to modify a few loose drivers / components which may need special
handling so that we could normalize on the intended grammatical
requirements. Just as with the ctrl work Joel did -- a few drives
needed to be modified so that the long term goal for the sentinel
could be applied.

I don't think time is wasted in formalizing this endeavor as it is
a generic goal we tend to see. We're breaking this down then into
a few goals, leaps:

 1) Start off with a few key special routines which deal with the
    data structure we want to constify, so we create grammar rules
    which modify the expected function data types with the one
    we are intersted in with const. The value in this is that
    Coccinelle will find changes we need outside of the scope of our
    build.

 2) Those routines then need checks to ensure that no variable is
    modified, so we need a scaper first to report these so we can
    inspect the routine and change it so that the grammar rule in
    1) works without any expected compile failure.

 3) Loosten the search to any routine that uses the struct we want
    to constify and address cases where the struct is used more than
    once in a routine.

 4) Ensure globally we don't modify the struct as done in the report
    on goal 1).

 5) Constify the struct

  Luis

