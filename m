Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8539F2588
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 03:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfKGCtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 21:49:39 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56989 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727443AbfKGCtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:49:39 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA72nLni011638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Nov 2019 21:49:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 799C4420311; Wed,  6 Nov 2019 21:49:19 -0500 (EST)
Date:   Wed, 6 Nov 2019 21:49:19 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/3] fscrypt: add support for IV_INO_LBLK_64 policies
Message-ID: <20191107024919.GH26959@mit.edu>
References: <20191024215438.138489-1-ebiggers@kernel.org>
 <20191024215438.138489-2-ebiggers@kernel.org>
 <20191106033544.GG26959@mit.edu>
 <20191106040519.GA705@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106040519.GA705@sol.localdomain>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 08:05:19PM -0800, Eric Biggers wrote:
> If we really wanted to optimize fscrypt_get_encryption_info(), I think we
> probably shouldn't try to microoptimize fscrypt_supported_policy(), but rather
> take advantage of the fact that fscrypt_has_permitted_context() already ran.
> E.g., we could cache the xattr, or skip both the keyring lookup and
> fscrypt_supported_policy() by grabbing them from the parent directory.

Yes, good point.  Certainly, if the parent is encrypted, given that we
force files to have the same policy as the containing directory,
there's no point calling fscrypt_supported_policy.  And if we're using
a policy which isn't using per-inode keys, then we can certainly just
grab the key from the parent directory.

				- Ted
