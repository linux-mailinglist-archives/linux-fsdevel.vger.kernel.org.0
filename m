Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188B314662C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAWK70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 05:59:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgAWK7Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:59:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483K5r5snRz9sSQ;
        Thu, 23 Jan 2020 21:59:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579777154;
        bh=HLfndF9RAt4g+AGkbC5qXfhi2W5ru43lrY+OrFwE77c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HSStN14FpEBPLwZGlx8oA+ZZNFfWdzHQErga4zK0XJhZfzP21D9wVvy2nuua2Mcro
         coc6kYH0eO3TodIQoXW3uHMTv0a3Qpku4sXMmh6C1rqkRglSS/MAUic6YqP0/byH0G
         ZJ7pawYuL1pjqPlF2vm4ykwCpFBmFOSc0iYPFqJZo0mEpsJQ76+wJbrBrKrEo9nmNs
         ZgSBsLMbn5gSujjwiM9+A2Ut5yJUmDY0rLKA8hcDKkIQJCPsjUpvQ3nRRKQRMY/OPV
         I80FJuKhnIDrVr9c3L0OKrBKo50KaQQi2hgOJyv7mbq1cJ3kvDlZyYKoDIRW7yeq51
         dxF8E/uUq8TlQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/6] powerpc/32s: prepare prevent_user_access() for user_access_end()
In-Reply-To: <824b69f5452d1d41d12c4dbd306d4b8f32d493fc.1579715466.git.christophe.leroy@c-s.fr>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr> <824b69f5452d1d41d12c4dbd306d4b8f32d493fc.1579715466.git.christophe.leroy@c-s.fr>
Date:   Thu, 23 Jan 2020 21:59:07 +1100
Message-ID: <87pnfaiglg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> In preparation of implementing user_access_begin and friends
> on powerpc, the book3s/32 version of prevent_user_access() need
> to be prepared for user_access_end().
>
> user_access_end() doesn't provide the address and size which
> were passed to user_access_begin(), required by prevent_user_access()
> to know which segment to modify.
>
> The list of segments which where unprotected by allow_user_access()
> are available in current->kuap. But we don't want prevent_user_access()
> to read this all the time, especially everytime it is 0 (for instance
> because the access was not a write access).
>
> Implement a special direction case named KUAP_SELF. In this case only,
> the addr and end are retrieved from current->kuap.

Can we call it KUAP_CURRENT?

ie. "use the KUAP state in current"

cheers
