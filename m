Return-Path: <linux-fsdevel+bounces-76947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANBmBQKTjGlQrAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:32:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979B1253FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DE5730166D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867B276028;
	Wed, 11 Feb 2026 14:31:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA03927AC4C;
	Wed, 11 Feb 2026 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820303; cv=none; b=ux9GgmGzzqQsCyvJAcfO997OXzp231L415+fQIxu947m6EHUOxOdN1K4OXb78w9HsAV5FnRae9ImzQ2FDPpsXst9g9eKdFGyU/2CUJG4dFZYl1HbYz2VVEOm0fkpQO2EhsYfE0UuTY+qusMblyag7GoTgslAYmG2chgEP0ENYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820303; c=relaxed/simple;
	bh=OBwfBDOtRxOg+R3bb3Yi0+4D8h91T4cO9da6oMYbtC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZctLl344uSuhYO2BWxn8z7mj6W7SYTz43L0Q1C8TuSUo78kfnbqZUYmFDw7ZmFhEkNjMe06bXlNPTMz3IlPJ11MrJM153lFD+9LxHZ0qpE8HY1gxbblYhwD6Ap6IwOAwc7eqs215Sa/VIEL4ka4BYKsbp5F3hKqXKSBimc88CUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 487E758C7D;
	Wed, 11 Feb 2026 14:31:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf10.hostedemail.com (Postfix) with ESMTPA id E436132;
	Wed, 11 Feb 2026 14:31:19 +0000 (UTC)
Date: Wed, 11 Feb 2026 08:31:18 -0600
From: John Groves <John@groves.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <john@jagalactic.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V4 0/2] ndctl: Add daxctl support for the new "famfs"
 mode of devdax
Message-ID: <aYyRBy5rBjTLSJQ6@groves.net>
References: <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
 <20260118223548.92823-1-john@jagalactic.com>
 <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
 <aYpp_ShERlNvt4T_@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYpp_ShERlNvt4T_@aschofie-mobl2.lan>
X-Stat-Signature: bz6hwcxgps4omkj531ayzua3gwddyxmw
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1+hsuGVOzSoRmhG2uC2cMlG3mLFFMoUNX0=
X-HE-Tag: 1770820279-956788
X-HE-Meta: U2FsdGVkX1/48tJ62rULMSB9K53/6K/1QehgF1yV9X74ahT4djs79150XoNYT9tLpZ+HpETC+WgoG/+rw+TvfcABVoQERj6emgHLLpO26wBrInhGj5bdC+1T3lVP5KKb48pfb5KTtBc4olxUi9NSS0f2cwo6BDjr7I+hNooZsy+yDYFZXSLnXpR4rhHRWP20kd0CybImaKcTcuGAyfNUOnGOf0zhGiWPTrZaHa6JUWPefJSpVNnXEqOnmez5o1oFvNv9Rw0AAk+ks7ICUARcoqPLcRLY/Cu+kwdgj9cl10LYHIzyPtmLXg8+r0g7hit4FTehOcoMnU8c9Wl0MzfpfskKIegTIeZhgBQvHA5ufkzFwTUpHk8A61I28+ymnJ1K
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76947-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jagalactic.com,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[groves.net];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John@groves.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,daxctl-famfs.sh:url,groves.net:mid,groves.net:email]
X-Rspamd-Queue-Id: 9979B1253FB
X-Rspamd-Action: no action

On 26/02/09 03:13PM, Alison Schofield wrote:
> On Sun, Jan 18, 2026 at 10:36:02PM +0000, John Groves wrote:
> > From: John Groves <john@groves.net>
> > 
> > No change since V2 - re-sending due to technical challenges.
> > 
> > No change since V1 - reposting as V2 to keep this with the related
> > kernel (dax and fuse) patches and libfuse patches.
> > 
> > This short series adds support and tests to daxctl for famfs[1]. The
> > famfs kernel patch series, under the same "compound cover" as this
> > series, adds a new 'fsdev_dax' driver for devdax. When that driver
> > is bound (instead of device_dax), the device is in 'famfs' mode rather
> > than 'devdax' mode.
> > 
> 
> Hi John, 
> 
> I fired this all up and ran it. It got through all but it's last test
> case before failing.
> 
> Three things appended:
> 1) the diff I applied to daxctl-famfs.sh to run the test
> 2) testlog.txt output of the test
> 3) RIP: 0010:is_free_buddy_page+0x39/0x60 kernel log
> 
> 
> 1) Diff I applied to execute the test:
> 
> diff --git a/test/daxctl-famfs.sh b/test/daxctl-famfs.sh
> index 12fbfefa3144..a4e8d87b9762 100755
> --- a/test/daxctl-famfs.sh
> +++ b/test/daxctl-famfs.sh
> @@ -9,6 +9,17 @@ rc=77
>  
>  trap 'cleanup $LINENO' ERR
>  
> +# Use cxl-test module to get the DAX device of the CXL auto region,
> +# which also makes this test NON destructive.
> +#
> +# The $CXL list below is a delay because find_daxdev() was not
> +# finding the DAX region without it.
> +#
> +modprobe -r cxl-test
> +modprobe cxl-test
> +$CXL list
> +
> +
>  daxdev=""
>  original_mode=""

[snip]

Thank you Allison! I'm still working to reproduce the BUG you found (and 
cover this in my jenkins automation), but I think I have the fix already: 
when existing famfs mode (unbinding drivers/dax/fsdev.c), a
fsdev_clear_folio_state() call is needed. I've added that for v8 as a devm
action...

I'm not 100% up to speed on how to use the test infrastructure, and may
ping you with questions later...

Regards,
John


