Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92B234D21F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhC2OIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhC2OIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:08:05 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DBA9C061574;
        Mon, 29 Mar 2021 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=VfPMjDwjvWO/gvhh8XIRrpTbM/hsolKR49fm
        bl1K1rc=; b=phb/yo/G0uXyYTms1ENnmZ6GqqHBEdAwGMO94Nz8fWVZZB1rhJEN
        Ocq9V48XfbiWTZKJzCPeXIfFe/qmm/YB1rSNpC6P0Ck1ABtSIidtVGfadzRwmAdL
        IOQkuLGVA8ZD8kv7CS6fLLJerkc00BuHHUgXgWtUuTt16VzjlkfvPeE=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Mon, 29 Mar
 2021 22:07:52 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Mon, 29 Mar 2021 22:07:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Jan Kara" <jack@suse.cz>
Cc:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [BUG] fs/notify/mark: A potential use after free in
 fsnotify_put_mark_wake
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <20210329135740.GB4283@quack2.suse.cz>
References: <39095113.1936a.178781a774a.Coremail.lyl2019@mail.ustc.edu.cn>
 <20210329135740.GB4283@quack2.suse.cz>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <560cb051.1d0ba.1787e4ff42a.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygAHD0M532FgxERoAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsPBlQhn5hpXgAGsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkphbiBLYXJhIiA8
amFja0BzdXNlLmN6Pg0KPiDlj5HpgIHml7bpl7Q6IDIwMjEtMDMtMjkgMjE6NTc6NDAgKOaYn+ac
n+S4gCkNCj4g5pS25Lu25Lq6OiBseWwyMDE5QG1haWwudXN0Yy5lZHUuY24NCj4g5oqE6YCBOiBq
YWNrQHN1c2UuY3osIGFtaXI3M2lsQGdtYWlsLmNvbSwgbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5l
bC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTogW0JVR10g
ZnMvbm90aWZ5L21hcms6IEEgcG90ZW50aWFsIHVzZSBhZnRlciBmcmVlIGluIGZzbm90aWZ5X3B1
dF9tYXJrX3dha2UNCj4gDQo+IEhlbGxvIQ0KPiANCj4gDQo+IE9uIFN1biAyOC0wMy0yMSAxNzox
MTo0MywgbHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuIHdyb3RlOg0KPiA+ICAgICBNeSBzdGF0aWMg
YW5hbHl6ZXIgdG9vbCByZXBvcnRlZCBhIHVzZSBhZnRlciBmcmVlIGluIGZzbm90aWZ5X3B1dF9t
YXJrX3dha2UNCj4gPiBvZiB0aGUgZmlsZTogZnMvbm90aWZ5L21hcmsuYy4NCj4gPiANCj4gPiBJ
biBmc25vdGlmeV9wdXRfbWFya193YWtlLCBpdCBjYWxscyBmc25vdGlmeV9wdXRfbWFyayhtYXJr
KS4gSW5zaWRlIHRoZSBmdW5jdGlvbg0KPiA+IGZzbm90aWZ5X3B1dF9tYXJrKCksIGlmIGNvbm4g
aXMgTlVMTCwgaXQgd2lsbCBjYWxsIGZzbm90aWZ5X2ZpbmFsX21hcmtfZGVzdHJveShtYXJrKQ0K
PiA+IHRvIGZyZWUgbWFyay0+Z3JvdXAgYnkgZnNub3RpZnlfcHV0X2dyb3VwKGdyb3VwKSBhbmQg
cmV0dXJuLiBJIGFsc28gaGFkIGluc3BlY3RlZA0KPiA+IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBm
c25vdGlmeV9wdXRfZ3JvdXAoKSBhbmQgZm91bmQgdGhhdCB0aGVyZSBpcyBubyBjbGVhbnVwIG9w
ZXJhdGlvbg0KPiA+IGFib3V0IGdyb3VwLT51c2VyX3dhaXRzLg0KPiA+IA0KPiA+IEJ1dCBhZnRl
ciBmc25vdGlmeV9wdXRfbWFya193YWtlKCkgcmV0dXJuZWQsIG1hcmstPmdyb3VwIGlzIHN0aWxs
IHVzZWQgYnkgDQo+ID4gaWYgKGF0b21pY19kZWNfYW5kX3Rlc3QoJmdyb3VwLT51c2VyX3dhaXRz
KSAmJiBncm91cC0+c2h1dGRvd24pIGFuZCBsYXRlci4NCj4gPiANCj4gPiBJcyB0aGlzIGFuIGlz
c3VlPw0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIHNjZW5hcmlvIGlzIHBvc3NpYmxlLiBmc25v
dGlmeV9wdXRfbWFya193YWtlKCkgY2FuIGJlDQo+IGNhbGxlZCBvbmx5IGZvciBtYXJrcyBhdHRh
Y2hlZCB0byBvYmplY3RzIGFuZCB0aGVzZSBoYXZlIG1hcmstPmNvbm4gIT0NCj4gTlVMTCBhbmQg
d2UgYXJlIHN1cmUgdGhhdCBmc25vdGlmeV9kZXN0cm95X2dyb3VwKCkgd2lsbCB3YWl0IGZvciBh
bGwgc3VjaA0KPiBtYXJrcyB0byBiZSB0b3JuIGRvd24gYW5kIGZyZWVkIGJlZm9yZSBkcm9wcGlu
ZyBsYXN0IGdyb3VwIHJlZmVyZW5jZSBhbmQNCj4gZnJlZWluZyB0aGUgZ3JvdXAuDQo+IA0KPiAJ
CQkJCQkJCUhvbnphDQo+IC0tIA0KPiBKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4NCj4gU1VTRSBM
YWJzLCBDUg0KDQoNCk9rLCB0aGFua3MgZm9yIHlvdXIgYW5zd2VyLg0K
