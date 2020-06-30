Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16420EEEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgF3HEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 03:04:38 -0400
Received: from verein.lst.de ([213.95.11.211]:34880 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730570AbgF3HEi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:04:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5597F68AFE; Tue, 30 Jun 2020 09:04:34 +0200 (CEST)
Date:   Tue, 30 Jun 2020 09:04:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200630070434.GA28654@lst.de>
References: <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com> <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com> <20200629152912.GA26172@lst.de> <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com> <20200629180730.GA4600@lst.de> <CAHk-=whzz81Cjfn+SNbLT8WvRxfQYbiAemKrQ5jpNAgxxDQhZA@mail.gmail.com> <20200629183636.GA6539@lst.de> <CAHk-=whE2_YcRRQhJ73s4kYqTNDkYqq2HHtieQ-R1J+Awgk=nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whE2_YcRRQhJ73s4kYqTNDkYqq2HHtieQ-R1J+Awgk=nA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Next fund one, in net/ipv6/ip6_flowlabel.c:ipv6_flowlabel_opt() we
have this gem toward the end:

		if (!freq->flr_label) {
			if (copy_to_user(&((struct in6_flowlabel_req __user *)optval)->flr_label,
					 &fl->label, sizeof(fl->label))) {
				/* Intentionally ignore fault. */

so it writes back to what was supposed to be the input parameter,
and only does it for a partial region.  Not sure how we could handle
that with any kind of copy to kernel in the caller scheme?
