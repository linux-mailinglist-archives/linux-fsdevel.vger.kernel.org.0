Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5847D78044
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfG1Pkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 11:40:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33128 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbfG1Pkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:40:53 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6SFeXgD004159
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jul 2019 11:40:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6A6464202F5; Sun, 28 Jul 2019 11:40:32 -0400 (EDT)
Date:   Sun, 28 Jul 2019 11:40:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 05/16] fscrypt: refactor v1 policy key setup into
 keysetup_legacy.c
Message-ID: <20190728154032.GE6088@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-6-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:30PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for introducing v2 encryption policies which will find
> and derive encryption keys differently from the current v1 encryption
> policies, refactor the v1 policy-specific key setup code from keyinfo.c
> into keysetup_legacy.c.  Then rename keyinfo.c to keysetup.c.

I'd use keysetup_v1.c, myself.  We can hope that we've gotten it right
with v2 and we'll never need to do another version, but *something* is
going to come up eventually which will require a v3 keysetup , whether
it's post-quantuum cryptography or something else we can't anticipate
right now.

For an example of the confusion that can result, one good example is
in the fs/quota subsystem, where QFMT_VFS_OLD, QFMT_VFS_V0, and
QFMT_VFS_V1 maps to quota_v1 and quota_v2 in an amusing and
non-obvious way.  (Go ahead, try to guess before you go look at the
code.  :-)

Other than that, looks good.  We can always move code around or rename
files in the future, so I'm not going to insist on doing it now (but
it would be my preference).

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
						
