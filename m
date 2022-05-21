Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B6352F954
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 08:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiEUGoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiEUGoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 02:44:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9C115EA4C;
        Fri, 20 May 2022 23:44:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f4so17556780lfu.12;
        Fri, 20 May 2022 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=QHamN3EP3mg3wYG0JgE2ziNRWwKsQTl7d+MktY36Nz4=;
        b=NblzhVVQPRmWkMP6spPE8x02uAuOuA4aQb0I9Rmzpfy1EZU74L/W4IdL2yhc93EMcU
         SaaRMv+GLDlpuS6QI/6NX2TexoAXCcXVMuaIteJBAaGw+g03F/YKZlqmcd/yOMC0hjce
         JrnSbgo81n97ogieyZdVB3oXXfGd8O9lJi1YTF7GrKJzZcQ5gppxoEYg4QJCTuptTuZ7
         B+vJgKT9w89WDs5C8PZR+WQeOBTCyTxLzZXv5Fvi1m3bVsTWkNrXeSrN2i4Lx3sqWJUD
         pwH0lHyTV4ug8c2sA2mq03Y3DaoKi9QTyRTeFf6aqU096FMz39pkmxrcMw4h1AfZnGxn
         njCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=QHamN3EP3mg3wYG0JgE2ziNRWwKsQTl7d+MktY36Nz4=;
        b=0QblJOcGapSbQgYeZaxSry6BeplQBCTMUGjue7ZxS3CWNt2plB4nn4AbanlfX9YdIF
         RuO7+EkZ3U08LZAOEe0rXweF8Glo952RzzBPoY85vXzyZWiWT9MXBay88NOWj0j2NMVG
         vLyVmVltORkol+Nf+E+5st0Lm5sjWXyzQqrlzw/bs8/UzREpV6llLrUZ0Vb+FgFA5w4y
         j8nbAGJrPPCYUr7ApDMOXdB1sPsei6jwICk3pEC5qIBzukYn+Z2gfNMYzrULPmnrITMR
         VXEexeOUL8TV8QXc6FzBDKRceUF2PdxmFGk47605TH9PzMr5ljK92AOlGCjYTF6Y+SOn
         rOFg==
X-Gm-Message-State: AOAM532NsBHPN5U+m2AFOw3eTYkhXlKW36vNx1UQL5kHJ8YLgo6VtZIt
        +U3ma2ujNNmMGoqmLw9qjsw=
X-Google-Smtp-Source: ABdhPJyU9Uzt+RWumuWcpxWpCWKF1ARlCBAYi4xuKUSfm7cp1Nh/AY6F80ihV3azK5nXUDVOHmi/Zg==
X-Received: by 2002:ac2:5229:0:b0:476:7a25:374c with SMTP id i9-20020ac25229000000b004767a25374cmr9277403lfl.97.1653115458985;
        Fri, 20 May 2022 23:44:18 -0700 (PDT)
Received: from dy55dwdd0t4mvl-w96f1t-4.rev.dnainternet.fi (dy55dwdd0t4mvl-w96f1t-4.rev.dnainternet.fi. [2001:14bb:672:390c:7e86:1514:fe5d:d12b])
        by smtp.gmail.com with ESMTPSA id h7-20020ac250c7000000b0047255d21174sm940350lfm.163.2022.05.20.23.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 23:44:18 -0700 (PDT)
Message-ID: <a8899b444011db4a0f8f45e004b488c37f34e282.camel@gmail.com>
Subject: Re: [PATCH] afs: Fix afs_getattr() to refetch file status if
 callback break occurred
From:   markus.suvanto@gmail.com
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 May 2022 09:44:11 +0300
In-Reply-To: <165308359800.162686.14122417881564420962.stgit@warthog.procyon.org.uk>
References: <165308359800.162686.14122417881564420962.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cGUsIDIwMjItMDUtMjAga2VsbG8gMjI6NTMgKzAxMDAsIERhdmlkIEhvd2VsbHMga2lyam9pdHRp
Ogo+IElmIGEgY2FsbGJhY2sgYnJlYWsgb2NjdXJzIChjaGFuZ2Ugbm90aWZpY2F0aW9uKSwgYWZz
X2dldGF0dHIoKSBuZWVkcwo+IHRvCj4gaXNzdWUgYW4gRlMuRmV0Y2hTdGF0dXMgUlBDIG9wZXJh
dGlvbiB0byB1cGRhdGUgdGhlIHN0YXR1cyBvZiB0aGUKPiBmaWxlCj4gYmVpbmcgZXhhbWluZWQg
YnkgdGhlIHN0YXQtZmFtaWx5IG9mIHN5c3RlbSBjYWxscy4KPiAKPiBGaXggYWZzX2dldGF0dHIo
KSB0byBkbyB0aGlzIGlmIEFGU19WTk9ERV9DQl9QUk9NSVNFRCBoYXMgYmVlbgo+IGNsZWFyZWQg
b24gYQo+IHZub2RlIGJ5IGEgY2FsbGJhY2sgYnJlYWsuwqAgU2tpcCB0aGlzIGlmIEFUX1NUQVRY
X0RPTlRfU1lOQyBpcyBzZXQuCj4gCj4gVGhpcyBjYW4gYmUgdGVzdGVkIGJ5IGFwcGVuZGluZyB0
byBhIGZpbGUgb24gb25lIEFGUyBjbGllbnQgYW5kIHRoZW4KPiB1c2luZwo+ICJzdGF0IC1MIiB0
byBleGFtaW5lIGl0cyBsZW5ndGggb24gYSBtYWNoaW5lIHJ1bm5pbmcga2Fmcy7CoCBUaGlzIGNh
bgo+IGFsc28KPiBiZSB3YXRjaGVkIHRocm91Z2ggdHJhY2luZyBvbiB0aGUga2FmcyBtYWNoaW5l
LsKgIFRoZSBjYWxsYmFjayBicmVhawo+IGlzCj4gc2VlbjoKPiAKPiDCoMKgwqDCoCBrd29ya2Vy
LzE6MS00NsKgwqDCoMKgwqAgWzAwMV0gLi4uLi7CoMKgIDk3OC45MTA4MTI6IGFmc19jYl9jYWxs
Ogo+IGM9MDAwMDAwNWYgWUZTQ0IuQ2FsbEJhY2sKPiDCoMKgwqDCoCBrd29ya2VyLzE6MS00NsKg
wqDCoMKgwqAgWzAwMV0gLi4uMS7CoMKgIDk3OC45MTA4Mjk6IGFmc19jYl9icmVhazoKPiAxMDAw
NTg6MjNiNGM6MjQyZDJjMiBiPTIgcz0xIGJyZWFrLWNiCj4gwqDCoMKgwqAga3dvcmtlci8xOjEt
NDbCoMKgwqDCoMKgIFswMDFdIC4uLi4uwqDCoCA5NzguOTExMDYyOiBhZnNfY2FsbF9kb25lOsKg
wqDCoAo+IGM9MDAwMDAwNWYgcmV0PTAgYWI9MCBbMDAwMDAwMDA4Mjk5NGVhZF0KPiAKPiBBbmQg
dGhlbiB0aGUgc3RhdCBjb21tYW5kIGdlbmVyYXRlZCBubyB0cmFmZmljIGlmIHVucGF0Y2hlZCwg
YnV0IHdpdGgKPiB0aGlzCj4gY2hhbmdlIGEgY2FsbCB0byBmZXRjaCB0aGUgc3RhdHVzIGNhbiBi
ZSBvYnNlcnZlZDoKPiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXQtNDQ3McKgwqDCoCBb
MDAwXSAuLi4uLsKgwqAgOTg2Ljc0NDEyMjogYWZzX21ha2VfZnNfY2FsbDoKPiBjPTAwMDAwMGFi
IDEwMDA1ODowMjNiNGM6MjQyZDJjMiBZRlMuRmV0Y2hTdGF0dXMKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0YXQtNDQ3McKgwqDCoCBbMDAwXSAuLi4uLsKgwqAgOTg2Ljc0NTU3ODogYWZzX2Nh
bGxfZG9uZTrCoMKgwqAKPiBjPTAwMDAwMGFiIHJldD0wIGFiPTAgWzAwMDAwMDAwODdmYzhjODRd
Cj4gCj4gRml4ZXM6IDA4ZTBlN2M4MmVlYSAoIltBRl9SWFJQQ106IE1ha2UgdGhlIGluLWtlcm5l
bCBBRlMgZmlsZXN5c3RlbQo+IHVzZSBBRl9SWFJQQy4iKQo+IFJlcG9ydGVkLWJ5OiBNYXJrdXMg
U3V2YW50byA8bWFya3VzLnN1dmFudG9AZ21haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhdmlk
IEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+Cj4gY2M6IE1hcmMgRGlvbm5lIDxtYXJjLmRp
b25uZUBhdXJpc3Rvci5jb20+Cj4gY2M6IGxpbnV4LWFmc0BsaXN0cy5pbmZyYWRlYWQub3JnCj4g
TGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTYwMTAK
PiAtLS0KPiAKPiDCoGZzL2Fmcy9pbm9kZS5jIHzCoMKgIDE0ICsrKysrKysrKysrKystCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYg
LS1naXQgYS9mcy9hZnMvaW5vZGUuYyBiL2ZzL2Fmcy9pbm9kZS5jCj4gaW5kZXggMmZlNDAyNDgz
YWQ1Li4zMGIwNjYyOTlkMzkgMTAwNjQ0Cj4gLS0tIGEvZnMvYWZzL2lub2RlLmMKPiArKysgYi9m
cy9hZnMvaW5vZGUuYwo+IEBAIC03NDAsMTAgKzc0MCwyMiBAQCBpbnQgYWZzX2dldGF0dHIoc3Ry
dWN0IHVzZXJfbmFtZXNwYWNlCj4gKm1udF91c2VybnMsIGNvbnN0IHN0cnVjdCBwYXRoICpwYXRo
LAo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZF9pbm9kZShw
YXRoLT5kZW50cnkpOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWZzX3Zub2RlICp2bm9kZSA9
IEFGU19GU19JKGlub2RlKTsKPiAtwqDCoMKgwqDCoMKgwqBpbnQgc2VxID0gMDsKPiArwqDCoMKg
wqDCoMKgwqBzdHJ1Y3Qga2V5ICprZXk7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHJldCwgc2VxID0g
MDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBfZW50ZXIoInsgaW5vPSVsdSB2PSV1IH0iLCBpbm9k
ZS0+aV9pbm8sIGlub2RlLQo+ID5pX2dlbmVyYXRpb24pOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKg
aWYgKCEocXVlcnlfZmxhZ3MgJiBBVF9TVEFUWF9ET05UX1NZTkMpICYmCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgICF0ZXN0X2JpdChBRlNfVk5PREVfQ0JfUFJPTUlTRUQsICZ2bm9kZS0+ZmxhZ3Mp
KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtleSA9IGFmc19yZXF1ZXN0X2tl
eSh2bm9kZS0+dm9sdW1lLT5jZWxsKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKElTX0VSUihrZXkpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIoa2V5KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0ID0gYWZzX3ZhbGlkYXRlKHZub2RlLCBrZXkpOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBrZXlfcHV0KGtleSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmIChyZXQgPCAwKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIHJldDsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgwqDCoMKgwqDC
oMKgwqBkbyB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWFkX3NlcWJlZ2lu
X29yX2xvY2soJnZub2RlLT5jYl9sb2NrLCAmc2VxKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGdlbmVyaWNfZmlsbGF0dHIoJmluaXRfdXNlcl9ucywgaW5vZGUsIHN0YXQpOwo+
IAo+IAoKClRlc3RlZC1ieTogTWFya3VzIFN1dmFudG8gPG1hcmt1cy5zdXZhbnRvQGdtYWlsLmNv
bT4KCi1NYXJrdXMKCgo=

