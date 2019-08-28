Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9336AA0B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 22:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfH1UBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 16:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1UBi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:01:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9579F88313;
        Wed, 28 Aug 2019 20:01:38 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E57925C1D6;
        Wed, 28 Aug 2019 20:01:36 +0000 (UTC)
Date:   Wed, 28 Aug 2019 15:01:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: mmotm 2019-08-27-20-39 uploaded (objtool: xen)
Message-ID: <20190828200134.d3lwgyunlpxc6cbn@treble>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
 <8b09d93a-bc42-bd8e-29ee-cd37765f4899@infradead.org>
 <20190828171923.4sir3sxwsnc2pvjy@treble>
 <57d6ab2e-1bae-dca3-2544-4f6e6a936c3a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57d6ab2e-1bae-dca3-2544-4f6e6a936c3a@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 28 Aug 2019 20:01:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:56:25AM -0700, Randy Dunlap wrote:
> >> drivers/xen/gntdev.o: warning: objtool: gntdev_copy()+0x229: call to __ubsan_handle_out_of_bounds() with UACCESS enabled
> > 
> > Easy one :-)
> > 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 0c8e17f946cd..6a935ab93149 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -483,6 +483,7 @@ static const char *uaccess_safe_builtin[] = {
> >  	"ubsan_type_mismatch_common",
> >  	"__ubsan_handle_type_mismatch",
> >  	"__ubsan_handle_type_mismatch_v1",
> > +	"__ubsan_handle_out_of_bounds",
> >  	/* misc */
> >  	"csum_partial_copy_generic",
> >  	"__memcpy_mcsafe",
> > 
> 
> 
> then I get this one:
> 
> lib/ubsan.o: warning: objtool: __ubsan_handle_out_of_bounds()+0x5d: call to ubsan_prologue() with UACCESS enabled

And of course I jinxed it by calling it easy.

Peter, how do you want to handle this?

Should we just disable UACCESS checking in lib/ubsan.c?

-- 
Josh
