Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8393EDDC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhHPTVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhHPTU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629141627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aml0zRP9j/JKrfL2ZvZqM4B9YGM+m9UTU6MfKu4oLd0=;
        b=iuyBJAnTkNOuIhCtS8s5cEq62sVCTRlhz9EA+gJvBckRsx7TlgHK2WOrGAv5EGaqFeNRSP
        JXBDSzgEB50qE21m3ex1haMlBLYfu9N79jYEA6f9PsRtGB4iRa0MA5G1rNur+WjOOrpMs9
        6idkJX9LGdKfeatAvnLLywpbVIBqrMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-_oRRDnJ1M9SUGCSkyyi7JA-1; Mon, 16 Aug 2021 15:20:26 -0400
X-MC-Unique: _oRRDnJ1M9SUGCSkyyi7JA-1
Received: by mail-wr1-f70.google.com with SMTP id z1-20020adfdf810000b0290154f7f8c412so5785184wrl.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 12:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aml0zRP9j/JKrfL2ZvZqM4B9YGM+m9UTU6MfKu4oLd0=;
        b=QBE3KzV5tBvBTUydtVEy7PwSlQyrgK2+u8HzxNFGMagpUvuKAqmAPYUCVEAJZj6dji
         29wYqtSk5ITh9MTg7iaoeEH42JsLqQ11VbDmtkFJMiJq+4z460W/3B6NfQLZNtS1Vp6z
         ANfOFG57ZgV0AuGwiE6t1YKeaED+//zIEtKU8okGnuj79RnpBpmullkcRQF6TnbQdIO2
         8Gq4KGRRlNmVRIw30jSyTlOEtUR/5eJV56ZOJCKroLb2zNM4M3+NmlmNmhPGbYdbX5oQ
         jYzYNYhhaRH/Mm0d39TjZ+rPwHkVuXj2nCmdPVvck1h7KtD0euEi9Ucj53+R6domgQ2G
         ukDw==
X-Gm-Message-State: AOAM532fz1lFj43aCK5spYD0Ff1VLR4WY/Pyz6XckUMz28mH3AcSXPWD
        QP+pz3c5Z71xr/HkVv8fFkQI+wg9Yf5ztFQZ7nfW7ttfI324fuLVXSgfBTH/gL0d+wKC9IaS4Ow
        qAAKkPJz3o/54m8Fg1Vvs3zsohGiSwqyJ1wdLia+E5V8d5RQs9hav9ks0PT/DccrS6dRRs7lh6w
        ==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr587888wme.74.1629141624890;
        Mon, 16 Aug 2021 12:20:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjvCy/E4WNYhW5CKX5H7C+2GHzi2A1tcSHCvvKNSoeIapAbm2Iqz9COfFKrK3o9F/Cn93UJg==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr587873wme.74.1629141624634;
        Mon, 16 Aug 2021 12:20:24 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id y13sm8260wmj.27.2021.08.16.12.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 12:20:24 -0700 (PDT)
Subject: Re: [BUG] general protection fault when reading /proc/kcore
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YRqhqz35tm3hA9CG@krava>
 <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com> <YRqqqvaZHDu1IKrD@krava>
 <2b83f03c-e782-138d-6010-1e4da5829b9a@redhat.com>
 <YRq4typgRn342B4i@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b5f3a8b7-e913-2272-115a-677edd35a485@redhat.com>
Date:   Mon, 16 Aug 2021 21:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRq4typgRn342B4i@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTYuMDguMjEgMjE6MTIsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IE9uIE1vbiwgQXVn
IDE2LCAyMDIxIGF0IDA4OjM4OjQzUE0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3Rl
Og0KPj4gT24gMTYuMDguMjEgMjA6MTIsIEppcmkgT2xzYSB3cm90ZToNCj4+PiBPbiBNb24s
IEF1ZyAxNiwgMjAyMSBhdCAwNzo0OToxNVBNICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3
cm90ZToNCj4+Pj4gT24gMTYuMDguMjEgMTk6MzQsIEppcmkgT2xzYSB3cm90ZToNCj4+Pj4+
IGhpLA0KPj4+Pj4gSSdtIGdldHRpbmcgZmF1bHQgYmVsb3cgd2hlbiBydW5uaW5nOg0KPj4+
Pj4NCj4+Pj4+IAkjIGNhdCAvcHJvYy9rYWxsc3ltcyB8IGdyZXAga3N5c19yZWFkDQo+Pj4+
PiAJZmZmZmZmZmY4MTM2ZDU4MCBUIGtzeXNfcmVhZA0KPj4+Pj4gCSMgb2JqZHVtcCAtZCAt
LXN0YXJ0LWFkZHJlc3M9MHhmZmZmZmZmZjgxMzZkNTgwIC0tc3RvcC1hZGRyZXNzPTB4ZmZm
ZmZmZmY4MTM2ZDU5MCAvcHJvYy9rY29yZQ0KPj4+Pj4NCj4+Pj4+IAkvcHJvYy9rY29yZTog
ICAgIGZpbGUgZm9ybWF0IGVsZjY0LXg4Ni02NA0KPj4+Pj4NCj4+Pj4+IAlTZWdtZW50YXRp
b24gZmF1bHQNCj4+Pj4+DQo+Pj4+PiBhbnkgaWRlYT8gY29uZmlnIGlzIGF0dGFjaGVkDQo+
Pj4+DQo+Pj4+IEp1c3QgdHJpZWQgd2l0aCBhIGRpZmZlcmVudCBjb25maWcgb24gNS4xNC4w
LXJjNisNCj4+Pj4NCj4+Pj4gW3Jvb3RAbG9jYWxob3N0IH5dIyBjYXQgL3Byb2Mva2FsbHN5
bXMgfCBncmVwIGtzeXNfcmVhZA0KPj4+PiBmZmZmZmZmZjg5MjdhODAwIFQga3N5c19yZWFk
YWhlYWQNCj4+Pj4gZmZmZmZmZmY4OTMzMzY2MCBUIGtzeXNfcmVhZA0KPj4+Pg0KPj4+PiBb
cm9vdEBsb2NhbGhvc3Qgfl0jIG9iamR1bXAgLWQgLS1zdGFydC1hZGRyZXNzPTB4ZmZmZmZm
ZmY4OTMzMzY2MA0KPj4+PiAtLXN0b3AtYWRkcmVzcz0weGZmZmZmZmZmODkzMzM2NzANCj4+
Pj4NCj4+Pj4gYS5vdXQ6ICAgICBmaWxlIGZvcm1hdCBlbGY2NC14ODYtNjQNCj4+Pj4NCj4+
Pj4NCj4+Pj4NCj4+Pj4gVGhlIGtlcm5fYWRkcl92YWxpZChzdGFydCkgc2VlbXMgdG8gZmF1
bHQgaW4geW91ciBjYXNlLCB3aGljaCBpcyB3ZWlyZCwNCj4+Pj4gYmVjYXVzZSBpdCBtZXJl
bHkgd2Fsa3MgdGhlIHBhZ2UgdGFibGVzLiBCdXQgaXQgc2VlbXMgdG8gY29tcGxhaW4gYWJv
dXQgYQ0KPj4+PiBub24tY2Fub25pY2FsIGFkZHJlc3MgMHhmODg3ZmZjYmZmMDAwDQo+Pj4+
DQo+Pj4+IENhbiB5b3UgcG9zdCB5b3VyIFFFTVUgY21kbGluZT8gRGlkIHlvdSB0ZXN0IHRo
aXMgb24gb3RoZXIga2VybmVsIHZlcnNpb25zPw0KPj4+DQo+Pj4gSSdtIHVzaW5nIHZpcnQt
bWFuYWdlciBzbzoNCj4+Pg0KPj4+IC91c3IvYmluL3FlbXUtc3lzdGVtLXg4Nl82NCAtbmFt
ZSBndWVzdD1mZWRvcmEzMyxkZWJ1Zy10aHJlYWRzPW9uIC1TIC1vYmplY3Qgc2VjcmV0LGlk
PW1hc3RlcktleTAsZm9ybWF0PXJhdyxmaWxlPS92YXIvbGliL2xpYnZpcnQvcWVtdS9kb21h
aW4tMTMtZmVkb3JhMzMvbWFzdGVyLWtleS5hZXMgLW1hY2hpbmUgcGMtcTM1LTUuMSxhY2Nl
bD1rdm0sdXNiPW9mZix2bXBvcnQ9b2ZmLGR1bXAtZ3Vlc3QtY29yZT1vZmYsbWVtb3J5LWJh
Y2tlbmQ9cGMucmFtIC1jcHUgU2t5bGFrZS1TZXJ2ZXItSUJSUyxzcz1vbix2bXg9b24scGRj
bT1vbixoeXBlcnZpc29yPW9uLHRzYy1hZGp1c3Q9b24sY2xmbHVzaG9wdD1vbix1bWlwPW9u
LHBrdT1vbixzdGlicD1vbixhcmNoLWNhcGFiaWxpdGllcz1vbixzc2JkPW9uLHhzYXZlcz1v
bixpYnBiPW9uLGFtZC1zdGlicD1vbixhbWQtc3NiZD1vbixza2lwLWwxZGZsLXZtZW50cnk9
b24scHNjaGFuZ2UtbWMtbm89b24gLW0gODE5MiAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJh
bSxpZD1wYy5yYW0sc2l6ZT04NTg5OTM0NTkyIC1vdmVyY29tbWl0IG1lbS1sb2NrPW9mZiAt
c21wIDIwLHNvY2tldHM9MjAsY29yZXM9MSx0aHJlYWRzPTEgLXV1aWQgMjE4NWQ1YTktZGJh
ZC00ZDYxLWFhNGUtOTdhZjlmZDdlYmNhIC1uby11c2VyLWNvbmZpZyAtbm9kZWZhdWx0cyAt
Y2hhcmRldiBzb2NrZXQsaWQ9Y2hhcm1vbml0b3IsZmQ9MzYsc2VydmVyLG5vd2FpdCAtbW9u
IGNoYXJkZXY9Y2hhcm1vbml0b3IsaWQ9bW9uaXRvcixtb2RlPWNvbnRyb2wgLXJ0YyBiYXNl
PXV0YyxkcmlmdGZpeD1zbGV3IC1nbG9iYWwga3ZtLXBpdC5sb3N0X3RpY2tfcG9saWN5PWRl
bGF5IC1uby1ocGV0IC1uby1zaHV0ZG93biAtZ2xvYmFsIElDSDktTFBDLmRpc2FibGVfczM9
MSAtZ2xvYmFsIElDSDktTFBDLmRpc2FibGVfczQ9MSAtYm9vdCBzdHJpY3Q9b24gLWtlcm5l
bCAvaG9tZS9qb2xzYS9xZW11L3J1bi92bWxpbnV4IC1pbml0cmQgL2hvbWUvam9sc2EvcWVt
dS9ydW4vaW5pdHJkIC1hcHBlbmQgcm9vdD0vZGV2L21hcHBlci9mZWRvcmFfZmVkb3JhLXJv
b3Qgcm8gcmQubHZtLmx2PWZlZG9yYV9mZWRvcmEvcm9vdCBjb25zb2xlPXR0eTAgY29uc29s
ZT10dHlTMCwxMTUyMDAgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTAsY2hhc3Np
cz0xLGlkPXBjaS4xLGJ1cz1wY2llLjAsbXVsdGlmdW5jdGlvbj1vbixhZGRyPTB4MiAtZGV2
aWNlIHBjaWUtcm9vdC1wb3J0LHBvcnQ9MHgxMSxjaGFzc2lzPTIsaWQ9cGNpLjIsYnVzPXBj
aWUuMCxhZGRyPTB4Mi4weDEgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTIsY2hh
c3Npcz0zLGlkPXBjaS4zLGJ1cz1wY2llLjAsYWRkcj0weDIuMHgyIC1kZXZpY2UgcGNpZS1y
b290LXBvcnQscG9ydD0weDEzLGNoYXNzaXM9NCxpZD1wY2kuNCxidXM9cGNpZS4wLGFkZHI9
MHgyLjB4MyAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LHBvcnQ9MHgxNCxjaGFzc2lzPTUsaWQ9
cGNpLjUsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDQgLWRldmljZSBwY2llLXJvb3QtcG9ydCxw
b3J0PTB4MTUsY2hhc3Npcz02LGlkPXBjaS42LGJ1cz1wY2llLjAsYWRkcj0weDIuMHg1IC1k
ZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weDE2LGNoYXNzaXM9NyxpZD1wY2kuNyxidXM9
cGNpZS4wLGFkZHI9MHgyLjB4NiAtZGV2aWNlIHFlbXUteGhjaSxwMj0xNSxwMz0xNSxpZD11
c2IsYnVzPXBjaS4yLGFkZHI9MHgwIC1kZXZpY2UgdmlydGlvLXNlcmlhbC1wY2ksaWQ9dmly
dGlvLXNlcmlhbDAsYnVzPXBjaS4zLGFkZHI9MHgwIC1ibG9ja2RldiB7ImRyaXZlciI6ImZp
bGUiLCJmaWxlbmFtZSI6Ii92YXIvbGliL2xpYnZpcnQvaW1hZ2VzL2ZlZG9yYTMzLnFjb3cy
Iiwibm9kZS1uYW1lIjoibGlidmlydC0yLXN0b3JhZ2UiLCJhdXRvLXJlYWQtb25seSI6dHJ1
ZSwiZGlzY2FyZCI6InVubWFwIn0gLWJsb2NrZGV2IHsibm9kZS1uYW1lIjoibGlidmlydC0y
LWZvcm1hdCIsInJlYWQtb25seSI6ZmFsc2UsImRyaXZlciI6InFjb3cyIiwiZmlsZSI6Imxp
YnZpcnQtMi1zdG9yYWdlIiwiYmFja2luZyI6bnVsbH0gLWRldmljZSB2aXJ0aW8tYmxrLXBj
aSxidXM9cGNpLjQsYWRkcj0weDAsZHJpdmU9bGlidmlydC0yLWZvcm1hdCxpZD12aXJ0aW8t
ZGlzazAsYm9vdGluZGV4PTEgLWRldmljZSBpZGUtY2QsYnVzPWlkZS4wLGlkPXNhdGEwLTAt
MCAtbmV0ZGV2IHRhcCxmZD0zOCxpZD1ob3N0bmV0MCx2aG9zdD1vbix2aG9zdGZkPTM5IC1k
ZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQwLGlkPW5ldDAsbWFjPTUyOjU0
OjAwOmYzOmM2OmU3LGJ1cz1wY2kuMSxhZGRyPTB4MCAtY2hhcmRldiBwdHksaWQ9Y2hhcnNl
cmlhbDAgLWRldmljZSBpc2Etc2VyaWFsLGNoYXJkZXY9Y2hhcnNlcmlhbDAsaWQ9c2VyaWFs
MCAtY2hhcmRldiBzb2NrZXQsaWQ9Y2hhcmNoYW5uZWwwLGZkPTQwLHNlcnZlcixub3dhaXQg
LWRldmljZSB2aXJ0c2VyaWFscG9ydCxidXM9dmlydGlvLXNlcmlhbDAuMCxucj0xLGNoYXJk
ZXY9Y2hhcmNoYW5uZWwwLGlkPWNoYW5uZWwwLG5hbWU9b3JnLnFlbXUuZ3Vlc3RfYWdlbnQu
MCAtY2hhcmRldiBzcGljZXZtYyxpZD1jaGFyY2hhbm5lbDEsbmFtZT12ZGFnZW50IC1kZXZp
Y2UgdmlydHNlcmlhbHBvcnQsYnVzPXZpcnRpby1zZXJpYWwwLjAsbnI9MixjaGFyZGV2PWNo
YXJjaGFubmVsMSxpZD1jaGFubmVsMSxuYW1lPWNvbS5yZWRoYXQuc3BpY2UuMCAtZGV2aWNl
IHVzYi10YWJsZXQsaWQ9aW5wdXQwLGJ1cz11c2IuMCxwb3J0PTEgLXNwaWNlIHBvcnQ9NTkw
MCxhZGRyPTEyNy4wLjAuMSxkaXNhYmxlLXRpY2tldGluZyxpbWFnZS1jb21wcmVzc2lvbj1v
ZmYsc2VhbWxlc3MtbWlncmF0aW9uPW9uIC1kZXZpY2UgcXhsLXZnYSxpZD12aWRlbzAscmFt
X3NpemU9NjcxMDg4NjQsdnJhbV9zaXplPTY3MTA4ODY0LHZyYW02NF9zaXplX21iPTAsdmdh
bWVtX21iPTE2LG1heF9vdXRwdXRzPTEsYnVzPXBjaWUuMCxhZGRyPTB4MSAtZGV2aWNlIGlj
aDktaW50ZWwtaGRhLGlkPXNvdW5kMCxidXM9cGNpZS4wLGFkZHI9MHgxYiAtZGV2aWNlIGhk
YS1kdXBsZXgsaWQ9c291bmQwLWNvZGVjMCxidXM9c291bmQwLjAsY2FkPTAgLWNoYXJkZXYg
c3BpY2V2bWMsaWQ9Y2hhcnJlZGlyMCxuYW1lPXVzYnJlZGlyIC1kZXZpY2UgdXNiLXJlZGly
LGNoYXJkZXY9Y2hhcnJlZGlyMCxpZD1yZWRpcjAsYnVzPXVzYi4wLHBvcnQ9MiAtY2hhcmRl
diBzcGljZXZtYyxpZD1jaGFycmVkaXIxLG5hbWU9dXNicmVkaXIgLWRldmljZSB1c2ItcmVk
aXIsY2hhcmRldj1jaGFycmVkaXIxLGlkPXJlZGlyMSxidXM9dXNiLjAscG9ydD0zIC1kZXZp
Y2UgdmlydGlvLWJhbGxvb24tcGNpLGlkPWJhbGxvb24wLGJ1cz1wY2kuNSxhZGRyPTB4MCAt
b2JqZWN0IHJuZy1yYW5kb20saWQ9b2Jqcm5nMCxmaWxlbmFtZT0vZGV2L3VyYW5kb20gLWRl
dmljZSB2aXJ0aW8tcm5nLXBjaSxybmc9b2Jqcm5nMCxpZD1ybmcwLGJ1cz1wY2kuNixhZGRy
PTB4MCAtc2FuZGJveCBvbixvYnNvbGV0ZT1kZW55LGVsZXZhdGVwcml2aWxlZ2VzPWRlbnks
c3Bhd249ZGVueSxyZXNvdXJjZWNvbnRyb2w9ZGVueSAtbXNnIHRpbWVzdGFtcD1vbg0KPiAg
IA0KPiANCj4gDQo+Pj4gc28gZmFyIEkgdGVzdGVkIGp1c3QgYnBmLW5leHQvbWFzdGVyOg0K
Pj4+ICAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
YnBmL2JwZi1uZXh0LmdpdA0KPj4+DQo+Pg0KPj4gSnVzdCB0cmllZCB3aXRoIHVwc3RyZWFt
IExpbnV4ICg1LjE0LjAtcmM2KSBhbmQgeW91ciBjb25maWcgd2l0aG91dA0KPj4gdHJpZ2dl
cmluZyBpdC4gSSdtIHVzaW5nICItY3B1IGhvc3QiLCB0aG91Z2gsIG9uIGFuIEFNRCBSeXpl
biA5IDM5MDBYDQo+IA0KPiBXaXRoIEppcmkncyBjb25maWcgYW5kICctY3B1IDx2ZXJ5IGxv
bmcgc3RyaW5nPicgaXQgdHJpZ2dlcnMgZm9yIG1lIG9uDQo+IHY1LjE0LXJjNi4NCj4gDQo+
IEknbGwgYWxzbyB0cnkgdG8gdGFrZSBhIGxvb2sgdG9tb3Jyb3cuDQoNCk5vIGx1Y2sgaGVy
ZSBvbiBteSBBTUQgc3lzdGVtLCBldmVuIHdpdGggdGhhdCAnLWNwdSA8dmVyeSBsb25nIHN0
cmluZz4nLiANCk1heWJlIHNvbWUgcmVsZXZhbnQgQ1BVIGZlYXR1cmVzIGdldCBzaWxlbnRs
eSBpZ25vcmVkIGJlY2F1c2UgdGhleSBhcmUgDQpub3QgYWN0dWFsbHkgYXZhaWxhYmxlIG9u
IG15IHN5c3RlbS4NCg0KLS0gDQpUaGFua3MsDQoNCkRhdmlkIC8gZGhpbGRlbmINCg==

