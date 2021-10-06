Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C84241CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhJFPu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:50:58 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:53018 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbhJFPux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:50:53 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY985-00AWZP-As; Wed, 06 Oct 2021 15:46:49 +0000
Date:   Wed, 6 Oct 2021 15:46:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] pgflags_t
Message-ID: <YV3E6Ym1+T6Tyq17@zeniv-ca.linux.org.uk>
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
 <106400c5-d3f2-e858-186a-82f9b517917b@redhat.com>
 <YV3ArQxQ7CFzhBhR@zeniv-ca.linux.org.uk>
 <21ce511e-7cde-8bdb-b6c6-e1278681ebf6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ce511e-7cde-8bdb-b6c6-e1278681ebf6@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:32:39PM +0200, David Hildenbrand wrote:

> It feels to me like using __bitwise for access checks and then still
> modifying the __bitwise fields randomly via a backdoor. But sure, if it
> works, I'll be happy if we can use that.

__bitwise == "can't do anything other than bitwise operations without
an explicit force-cast".  All there is to it.  Hell, the very first
use had been for things like __le32 et.al., where the primitives
very much do non-bitwise accesses.  They are known to be safe (==
do the same thing regardless of the host endianness).  Internally
they contain force-casts, precisely so that the caller wouldn't
need to.
