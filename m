Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077DC737E45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjFUI7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 04:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjFUI7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:59:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADB9198B;
        Wed, 21 Jun 2023 01:59:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B052621A3A;
        Wed, 21 Jun 2023 08:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687337943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cE4WHlEnJ0+fRiIG+k9/kOsEuDt3YFqDcyluLQpY9Zs=;
        b=hr2SxkK2+ttMh6s9KmBpFQbhL/KQt92Q2mp4SsO+90+1/DIlQ1bC4/e2TrxyUvi0MrU4AL
        ShU+4woq3tJOVALrZzzJtL+DQwm4QOVZuKtkOj4TP4gWWcMby354Y+OY3liC1o5qbhoyaJ
        eOCFTkT9qnp4/ZyNVF/EyYeYrEEDi/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687337943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cE4WHlEnJ0+fRiIG+k9/kOsEuDt3YFqDcyluLQpY9Zs=;
        b=l93aS8M8bybNVVEyXVGjNy6/9zs4si5xQUF4q/6D3b6GfTl+cixKA6geNAJAq+QIrkgEAW
        HIs8Thdg6ubl+qBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9531C134B1;
        Wed, 21 Jun 2023 08:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z0rsI9e7kmROYgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 21 Jun 2023 08:59:03 +0000
Content-Type: multipart/mixed; boundary="------------Tqje0wnKGo5MkY8QZi0ViNAU"
Message-ID: <d0b77326-e93f-c1dc-c46c-1213bfafd7ee@suse.de>
Date:   Wed, 21 Jun 2023 10:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 2/4] filemap: use minimum order while allocating folios
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        david@fromorbit.com
Cc:     gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230621083823.1724337-1-p.raghav@samsung.com>
 <CGME20230621083827eucas1p2948b4efaf55064c3761c924b5b049219@eucas1p2.samsung.com>
 <20230621083823.1724337-3-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230621083823.1724337-3-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Tqje0wnKGo5MkY8QZi0ViNAU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/23 10:38, Pankaj Raghav wrote:
> Add support to filemap and readahead to use the folio order set by
> mapping_min_folio_order().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/filemap.c   |  9 ++++++---
>   mm/readahead.c | 34 ++++++++++++++++++++++++----------
>   2 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3b73101f9f86..9dc8568e9336 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1936,7 +1936,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>   			gfp |= GFP_NOWAIT | __GFP_NOWARN;
>   		}
>   
> -		folio = filemap_alloc_folio(gfp, 0);
> +		folio = filemap_alloc_folio(gfp,
> +					    mapping_min_folio_order(mapping));
>   		if (!folio)
>   			return ERR_PTR(-ENOMEM);
>   
> @@ -2495,7 +2496,8 @@ static int filemap_create_folio(struct file *file,
>   	struct folio *folio;
>   	int error;
>   
> -	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
> +	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
> +				    mapping_min_folio_order(mapping));
>   	if (!folio)
>   		return -ENOMEM;
>   
> @@ -3663,7 +3665,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
>   repeat:
>   	folio = filemap_get_folio(mapping, index);
>   	if (IS_ERR(folio)) {
> -		folio = filemap_alloc_folio(gfp, 0);
> +		folio = filemap_alloc_folio(gfp,
> +					    mapping_min_folio_order(mapping));
>   		if (!folio)
>   			return ERR_PTR(-ENOMEM);
>   		err = filemap_add_folio(mapping, folio, index, gfp);
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 47afbca1d122..090b810ddeed 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -245,7 +245,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>   			continue;
>   		}
>   
> -		folio = filemap_alloc_folio(gfp_mask, 0);
> +		folio = filemap_alloc_folio(gfp_mask,
> +					    mapping_min_folio_order(mapping));
>   		if (!folio)
>   			break;
>   		if (filemap_add_folio(mapping, folio, index + i,
> @@ -259,7 +260,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>   		if (i == nr_to_read - lookahead_size)
>   			folio_set_readahead(folio);
>   		ractl->_workingset |= folio_test_workingset(folio);
> -		ractl->_nr_pages++;
> +		ractl->_nr_pages += folio_nr_pages(folio);
> +		i += folio_nr_pages(folio) - 1;
>   	}
>   
>   	/*
This is incomplete, as the loop above has some exit statements which 
blindly step backwards by one page.

I found it better to rework the 'for' into a 'while' loop; please check 
the attached patch.

Cheers,

Hannes

--------------Tqje0wnKGo5MkY8QZi0ViNAU
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-mm-readahead-rework-loop-in-page_cache_ra_unbounded.patch"
Content-Disposition: attachment;
 filename*0="0004-mm-readahead-rework-loop-in-page_cache_ra_unbounded.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBiZGFiODBjMzlkNGRhMWQ0ZDVjNDc3MDZkODVlOGRlN2UzZDJkYTEwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4K
RGF0ZTogVHVlLCAyMCBKdW4gMjAyMyAwODo0OTozMSArMDIwMApTdWJqZWN0OiBbUEFUQ0gg
MDQvMThdIG1tL3JlYWRhaGVhZDogcmV3b3JrIGxvb3AgaW4gcGFnZV9jYWNoZV9yYV91bmJv
dW5kZWQoKQoKUmV3b3JrIHRoZSBsb29wIGluIHBhZ2VfY2FjaGVfcmFfdW5ib3VuZGVkKCkg
dG8gYWR2YW5jZSB3aXRoCnRoZSBudW1iZXIgb2YgcGFnZXMgaW4gYSBmb2xpbyBpbnN0ZWFk
IG9mIGp1c3Qgb25lIHBhZ2UgYXQgYSB0aW1lLgoKU2lnbmVkLW9mZi1ieTogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+Ci0tLQogbW0vcmVhZGFoZWFkLmMgfCAxNyArKysrKysr
KystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9tbS9yZWFkYWhlYWQuYyBiL21tL3JlYWRhaGVhZC5jCmlu
ZGV4IDQ3YWZiY2ExZDEyMi4uMTcwMDYwMzY4NWQwIDEwMDY0NAotLS0gYS9tbS9yZWFkYWhl
YWQuYworKysgYi9tbS9yZWFkYWhlYWQuYwpAQCAtMjA5LDcgKzIwOSw3IEBAIHZvaWQgcGFn
ZV9jYWNoZV9yYV91bmJvdW5kZWQoc3RydWN0IHJlYWRhaGVhZF9jb250cm9sICpyYWN0bCwK
IAlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IHJhY3RsLT5tYXBwaW5nOwogCXVu
c2lnbmVkIGxvbmcgaW5kZXggPSByZWFkYWhlYWRfaW5kZXgocmFjdGwpOwogCWdmcF90IGdm
cF9tYXNrID0gcmVhZGFoZWFkX2dmcF9tYXNrKG1hcHBpbmcpOwotCXVuc2lnbmVkIGxvbmcg
aTsKKwl1bnNpZ25lZCBsb25nIGkgPSAwOwogCiAJLyoKIAkgKiBQYXJ0d2F5IHRocm91Z2gg
dGhlIHJlYWRhaGVhZCBvcGVyYXRpb24sIHdlIHdpbGwgaGF2ZSBhZGRlZApAQCAtMjI3LDcg
KzIyNyw3IEBAIHZvaWQgcGFnZV9jYWNoZV9yYV91bmJvdW5kZWQoc3RydWN0IHJlYWRhaGVh
ZF9jb250cm9sICpyYWN0bCwKIAkvKgogCSAqIFByZWFsbG9jYXRlIGFzIG1hbnkgcGFnZXMg
YXMgd2Ugd2lsbCBuZWVkLgogCSAqLwotCWZvciAoaSA9IDA7IGkgPCBucl90b19yZWFkOyBp
KyspIHsKKwlkbyB7CiAJCXN0cnVjdCBmb2xpbyAqZm9saW8gPSB4YV9sb2FkKCZtYXBwaW5n
LT5pX3BhZ2VzLCBpbmRleCArIGkpOwogCiAJCWlmIChmb2xpbyAmJiAheGFfaXNfdmFsdWUo
Zm9saW8pKSB7CkBAIC0yNDAsOCArMjQwLDggQEAgdm9pZCBwYWdlX2NhY2hlX3JhX3VuYm91
bmRlZChzdHJ1Y3QgcmVhZGFoZWFkX2NvbnRyb2wgKnJhY3RsLAogCQkJICogbm90IHdvcnRo
IGdldHRpbmcgb25lIGp1c3QgZm9yIHRoYXQuCiAJCQkgKi8KIAkJCXJlYWRfcGFnZXMocmFj
dGwpOwotCQkJcmFjdGwtPl9pbmRleCsrOwotCQkJaSA9IHJhY3RsLT5faW5kZXggKyByYWN0
bC0+X25yX3BhZ2VzIC0gaW5kZXggLSAxOworCQkJcmFjdGwtPl9pbmRleCArPSBmb2xpb19u
cl9wYWdlcyhmb2xpbyk7CisJCQlpID0gcmFjdGwtPl9pbmRleCArIHJhY3RsLT5fbnJfcGFn
ZXMgLSBpbmRleDsKIAkJCWNvbnRpbnVlOwogCQl9CiAKQEAgLTI1MiwxNSArMjUyLDE2IEBA
IHZvaWQgcGFnZV9jYWNoZV9yYV91bmJvdW5kZWQoc3RydWN0IHJlYWRhaGVhZF9jb250cm9s
ICpyYWN0bCwKIAkJCQkJZ2ZwX21hc2spIDwgMCkgewogCQkJZm9saW9fcHV0KGZvbGlvKTsK
IAkJCXJlYWRfcGFnZXMocmFjdGwpOwotCQkJcmFjdGwtPl9pbmRleCsrOwotCQkJaSA9IHJh
Y3RsLT5faW5kZXggKyByYWN0bC0+X25yX3BhZ2VzIC0gaW5kZXggLSAxOworCQkJcmFjdGwt
Pl9pbmRleCArPSBmb2xpb19ucl9wYWdlcyhmb2xpbyk7CisJCQlpID0gcmFjdGwtPl9pbmRl
eCArIHJhY3RsLT5fbnJfcGFnZXMgLSBpbmRleDsKIAkJCWNvbnRpbnVlOwogCQl9CiAJCWlm
IChpID09IG5yX3RvX3JlYWQgLSBsb29rYWhlYWRfc2l6ZSkKIAkJCWZvbGlvX3NldF9yZWFk
YWhlYWQoZm9saW8pOwogCQlyYWN0bC0+X3dvcmtpbmdzZXQgfD0gZm9saW9fdGVzdF93b3Jr
aW5nc2V0KGZvbGlvKTsKLQkJcmFjdGwtPl9ucl9wYWdlcysrOwotCX0KKwkJcmFjdGwtPl9u
cl9wYWdlcyArPSBmb2xpb19ucl9wYWdlcyhmb2xpbyk7CisJCWkgKz0gZm9saW9fbnJfcGFn
ZXMoZm9saW8pOworCX0gd2hpbGUgKGkgPCBucl90b19yZWFkKTsKIAogCS8qCiAJICogTm93
IHN0YXJ0IHRoZSBJTy4gIFdlIGlnbm9yZSBJL08gZXJyb3JzIC0gaWYgdGhlIGZvbGlvIGlz
IG5vdAotLSAKMi4zNS4zCgo=

--------------Tqje0wnKGo5MkY8QZi0ViNAU--
