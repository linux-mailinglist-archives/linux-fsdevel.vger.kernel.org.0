Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C13EDD32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhHPSjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 14:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229921AbhHPSjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629139127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA6yIOrGFNdlfE76sJx2b7lSTjBBLY6+orZoIeN8qMc=;
        b=dAwKZOG+0SDoooBSMZdOMLG/r6uSDPliktN5u1WFXX2wlpR4pOGkgLxXYBa8p6whECaH7L
        wGRTcvYXGKObVARL4E2337AjZQmwOLKWNzpWNNZUYaGLyYyokrY0DqJICPuaVObjnXfQ7J
        kYLMDEyVGoWo5t+5FeBei5UO7yG9JgA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-zulmZe3XPpOj1ZvbWmklZA-1; Mon, 16 Aug 2021 14:38:45 -0400
X-MC-Unique: zulmZe3XPpOj1ZvbWmklZA-1
Received: by mail-wm1-f70.google.com with SMTP id r21-20020a05600c35d5b02902e685ef1f76so236636wmq.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 11:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FA6yIOrGFNdlfE76sJx2b7lSTjBBLY6+orZoIeN8qMc=;
        b=psjAWOnCiJafHgQPUa4yrnMiIRNhigNqkUO/2jdchymMAvo54R5qZYeXq2+msFBXXs
         uP/sPOL02D7kIbK49lPlQeGpUAEd7M+l5TSV6llL99NrBAwPmmuYeHW9WH2QPgwkTizs
         CS73SFoGjJXR/ioafwIk8Re7EO9Kg36mv1tKy6zxNO1urYE1X5/gUNJJDgUez0m8oCAR
         vIhos6DderX+ILi/KdWJS+OzzMer5HVc/peR7sFSUm0eFCT3sg9djYNXKj7NMvyiRQiD
         4ZMDywqWeKzDntI91g8T8CCJBMnHueZLIv+S9ABWEWNC8PcVQQisZ63f7l/mdV/t8OE/
         zwnA==
X-Gm-Message-State: AOAM5301dZx+7MbbmbgpGzZSekFSrgOOiOThDsQlID2oFIO0Dy/P68/j
        iEVMjI0nUv21yhgOzIRSOGtplSZ/1xPrDuaov/QDHowpvQWWPBGU3fA9jBAwSawGGT+ms7IHIne
        iubRaPo6eWp87syNay6pPFl53sPK6ZgZIJo7ajPAuW11J7tBrW8kH/9ypnM5VJj1JLi0ygij5RA
        ==
X-Received: by 2002:a05:600c:895:: with SMTP id l21mr409333wmp.173.1629139124617;
        Mon, 16 Aug 2021 11:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYCZW810CZv5LtOzXX2ljYIVlkPsa1xdjvzjO9BLHiKaFa7fSwR2MSxhZ1fd8KyQVgpy4qAg==
X-Received: by 2002:a05:600c:895:: with SMTP id l21mr409309wmp.173.1629139124360;
        Mon, 16 Aug 2021 11:38:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id u5sm12253671wrr.94.2021.08.16.11.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:38:44 -0700 (PDT)
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YRqhqz35tm3hA9CG@krava>
 <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com> <YRqqqvaZHDu1IKrD@krava>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [BUG] general protection fault when reading /proc/kcore
Message-ID: <2b83f03c-e782-138d-6010-1e4da5829b9a@redhat.com>
Date:   Mon, 16 Aug 2021 20:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRqqqvaZHDu1IKrD@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTYuMDguMjEgMjA6MTIsIEppcmkgT2xzYSB3cm90ZToNCj4gT24gTW9uLCBBdWcgMTYs
IDIwMjEgYXQgMDc6NDk6MTVQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+
PiBPbiAxNi4wOC4yMSAxOTozNCwgSmlyaSBPbHNhIHdyb3RlOg0KPj4+IGhpLA0KPj4+IEkn
bSBnZXR0aW5nIGZhdWx0IGJlbG93IHdoZW4gcnVubmluZzoNCj4+Pg0KPj4+IAkjIGNhdCAv
cHJvYy9rYWxsc3ltcyB8IGdyZXAga3N5c19yZWFkDQo+Pj4gCWZmZmZmZmZmODEzNmQ1ODAg
VCBrc3lzX3JlYWQNCj4+PiAJIyBvYmpkdW1wIC1kIC0tc3RhcnQtYWRkcmVzcz0weGZmZmZm
ZmZmODEzNmQ1ODAgLS1zdG9wLWFkZHJlc3M9MHhmZmZmZmZmZjgxMzZkNTkwIC9wcm9jL2tj
b3JlDQo+Pj4NCj4+PiAJL3Byb2Mva2NvcmU6ICAgICBmaWxlIGZvcm1hdCBlbGY2NC14ODYt
NjQNCj4+Pg0KPj4+IAlTZWdtZW50YXRpb24gZmF1bHQNCj4+Pg0KPj4+IGFueSBpZGVhPyBj
b25maWcgaXMgYXR0YWNoZWQNCj4+DQo+PiBKdXN0IHRyaWVkIHdpdGggYSBkaWZmZXJlbnQg
Y29uZmlnIG9uIDUuMTQuMC1yYzYrDQo+Pg0KPj4gW3Jvb3RAbG9jYWxob3N0IH5dIyBjYXQg
L3Byb2Mva2FsbHN5bXMgfCBncmVwIGtzeXNfcmVhZA0KPj4gZmZmZmZmZmY4OTI3YTgwMCBU
IGtzeXNfcmVhZGFoZWFkDQo+PiBmZmZmZmZmZjg5MzMzNjYwIFQga3N5c19yZWFkDQo+Pg0K
Pj4gW3Jvb3RAbG9jYWxob3N0IH5dIyBvYmpkdW1wIC1kIC0tc3RhcnQtYWRkcmVzcz0weGZm
ZmZmZmZmODkzMzM2NjANCj4+IC0tc3RvcC1hZGRyZXNzPTB4ZmZmZmZmZmY4OTMzMzY3MA0K
Pj4NCj4+IGEub3V0OiAgICAgZmlsZSBmb3JtYXQgZWxmNjQteDg2LTY0DQo+Pg0KPj4NCj4+
DQo+PiBUaGUga2Vybl9hZGRyX3ZhbGlkKHN0YXJ0KSBzZWVtcyB0byBmYXVsdCBpbiB5b3Vy
IGNhc2UsIHdoaWNoIGlzIHdlaXJkLA0KPj4gYmVjYXVzZSBpdCBtZXJlbHkgd2Fsa3MgdGhl
IHBhZ2UgdGFibGVzLiBCdXQgaXQgc2VlbXMgdG8gY29tcGxhaW4gYWJvdXQgYQ0KPj4gbm9u
LWNhbm9uaWNhbCBhZGRyZXNzIDB4Zjg4N2ZmY2JmZjAwMA0KPj4NCj4+IENhbiB5b3UgcG9z
dCB5b3VyIFFFTVUgY21kbGluZT8gRGlkIHlvdSB0ZXN0IHRoaXMgb24gb3RoZXIga2VybmVs
IHZlcnNpb25zPw0KPiANCj4gSSdtIHVzaW5nIHZpcnQtbWFuYWdlciBzbzoNCj4gDQo+IC91
c3IvYmluL3FlbXUtc3lzdGVtLXg4Nl82NCAtbmFtZSBndWVzdD1mZWRvcmEzMyxkZWJ1Zy10
aHJlYWRzPW9uIC1TIC1vYmplY3Qgc2VjcmV0LGlkPW1hc3RlcktleTAsZm9ybWF0PXJhdyxm
aWxlPS92YXIvbGliL2xpYnZpcnQvcWVtdS9kb21haW4tMTMtZmVkb3JhMzMvbWFzdGVyLWtl
eS5hZXMgLW1hY2hpbmUgcGMtcTM1LTUuMSxhY2NlbD1rdm0sdXNiPW9mZix2bXBvcnQ9b2Zm
LGR1bXAtZ3Vlc3QtY29yZT1vZmYsbWVtb3J5LWJhY2tlbmQ9cGMucmFtIC1jcHUgU2t5bGFr
ZS1TZXJ2ZXItSUJSUyxzcz1vbix2bXg9b24scGRjbT1vbixoeXBlcnZpc29yPW9uLHRzYy1h
ZGp1c3Q9b24sY2xmbHVzaG9wdD1vbix1bWlwPW9uLHBrdT1vbixzdGlicD1vbixhcmNoLWNh
cGFiaWxpdGllcz1vbixzc2JkPW9uLHhzYXZlcz1vbixpYnBiPW9uLGFtZC1zdGlicD1vbixh
bWQtc3NiZD1vbixza2lwLWwxZGZsLXZtZW50cnk9b24scHNjaGFuZ2UtbWMtbm89b24gLW0g
ODE5MiAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxpZD1wYy5yYW0sc2l6ZT04NTg5OTM0
NTkyIC1vdmVyY29tbWl0IG1lbS1sb2NrPW9mZiAtc21wIDIwLHNvY2tldHM9MjAsY29yZXM9
MSx0aHJlYWRzPTEgLXV1aWQgMjE4NWQ1YTktZGJhZC00ZDYxLWFhNGUtOTdhZjlmZDdlYmNh
IC1uby11c2VyLWNvbmZpZyAtbm9kZWZhdWx0cyAtY2hhcmRldiBzb2NrZXQsaWQ9Y2hhcm1v
bml0b3IsZmQ9MzYsc2VydmVyLG5vd2FpdCAtbW9uIGNoYXJkZXY9Y2hhcm1vbml0b3IsaWQ9
bW9uaXRvcixtb2RlPWNvbnRyb2wgLXJ0YyBiYXNlPXV0YyxkcmlmdGZpeD1zbGV3IC1nbG9i
YWwga3ZtLXBpdC5sb3N0X3RpY2tfcG9saWN5PWRlbGF5IC1uby1ocGV0IC1uby1zaHV0ZG93
biAtZ2xvYmFsIElDSDktTFBDLmRpc2FibGVfczM9MSAtZ2xvYmFsIElDSDktTFBDLmRpc2Fi
bGVfczQ9MSAtYm9vdCBzdHJpY3Q9b24gLWtlcm5lbCAvaG9tZS9qb2xzYS9xZW11L3J1bi92
bWxpbnV4IC1pbml0cmQgL2hvbWUvam9sc2EvcWVtdS9ydW4vaW5pdHJkIC1hcHBlbmQgcm9v
dD0vZGV2L21hcHBlci9mZWRvcmFfZmVkb3JhLXJvb3Qgcm8gcmQubHZtLmx2PWZlZG9yYV9m
ZWRvcmEvcm9vdCBjb25zb2xlPXR0eTAgY29uc29sZT10dHlTMCwxMTUyMDAgLWRldmljZSBw
Y2llLXJvb3QtcG9ydCxwb3J0PTB4MTAsY2hhc3Npcz0xLGlkPXBjaS4xLGJ1cz1wY2llLjAs
bXVsdGlmdW5jdGlvbj1vbixhZGRyPTB4MiAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LHBvcnQ9
MHgxMSxjaGFzc2lzPTIsaWQ9cGNpLjIsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDEgLWRldmlj
ZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTIsY2hhc3Npcz0zLGlkPXBjaS4zLGJ1cz1wY2ll
LjAsYWRkcj0weDIuMHgyIC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weDEzLGNoYXNz
aXM9NCxpZD1wY2kuNCxidXM9cGNpZS4wLGFkZHI9MHgyLjB4MyAtZGV2aWNlIHBjaWUtcm9v
dC1wb3J0LHBvcnQ9MHgxNCxjaGFzc2lzPTUsaWQ9cGNpLjUsYnVzPXBjaWUuMCxhZGRyPTB4
Mi4weDQgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTUsY2hhc3Npcz02LGlkPXBj
aS42LGJ1cz1wY2llLjAsYWRkcj0weDIuMHg1IC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9y
dD0weDE2LGNoYXNzaXM9NyxpZD1wY2kuNyxidXM9cGNpZS4wLGFkZHI9MHgyLjB4NiAtZGV2
aWNlIHFlbXUteGhjaSxwMj0xNSxwMz0xNSxpZD11c2IsYnVzPXBjaS4yLGFkZHI9MHgwIC1k
ZXZpY2UgdmlydGlvLXNlcmlhbC1wY2ksaWQ9dmlydGlvLXNlcmlhbDAsYnVzPXBjaS4zLGFk
ZHI9MHgwIC1ibG9ja2RldiB7ImRyaXZlciI6ImZpbGUiLCJmaWxlbmFtZSI6Ii92YXIvbGli
L2xpYnZpcnQvaW1hZ2VzL2ZlZG9yYTMzLnFjb3cyIiwibm9kZS1uYW1lIjoibGlidmlydC0y
LXN0b3JhZ2UiLCJhdXRvLXJlYWQtb25seSI6dHJ1ZSwiZGlzY2FyZCI6InVubWFwIn0gLWJs
b2NrZGV2IHsibm9kZS1uYW1lIjoibGlidmlydC0yLWZvcm1hdCIsInJlYWQtb25seSI6ZmFs
c2UsImRyaXZlciI6InFjb3cyIiwiZmlsZSI6ImxpYnZpcnQtMi1zdG9yYWdlIiwiYmFja2lu
ZyI6bnVsbH0gLWRldmljZSB2aXJ0aW8tYmxrLXBjaSxidXM9cGNpLjQsYWRkcj0weDAsZHJp
dmU9bGlidmlydC0yLWZvcm1hdCxpZD12aXJ0aW8tZGlzazAsYm9vdGluZGV4PTEgLWRldmlj
ZSBpZGUtY2QsYnVzPWlkZS4wLGlkPXNhdGEwLTAtMCAtbmV0ZGV2IHRhcCxmZD0zOCxpZD1o
b3N0bmV0MCx2aG9zdD1vbix2aG9zdGZkPTM5IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0
ZGV2PWhvc3RuZXQwLGlkPW5ldDAsbWFjPTUyOjU0OjAwOmYzOmM2OmU3LGJ1cz1wY2kuMSxh
ZGRyPTB4MCAtY2hhcmRldiBwdHksaWQ9Y2hhcnNlcmlhbDAgLWRldmljZSBpc2Etc2VyaWFs
LGNoYXJkZXY9Y2hhcnNlcmlhbDAsaWQ9c2VyaWFsMCAtY2hhcmRldiBzb2NrZXQsaWQ9Y2hh
cmNoYW5uZWwwLGZkPTQwLHNlcnZlcixub3dhaXQgLWRldmljZSB2aXJ0c2VyaWFscG9ydCxi
dXM9dmlydGlvLXNlcmlhbDAuMCxucj0xLGNoYXJkZXY9Y2hhcmNoYW5uZWwwLGlkPWNoYW5u
ZWwwLG5hbWU9b3JnLnFlbXUuZ3Vlc3RfYWdlbnQuMCAtY2hhcmRldiBzcGljZXZtYyxpZD1j
aGFyY2hhbm5lbDEsbmFtZT12ZGFnZW50IC1kZXZpY2UgdmlydHNlcmlhbHBvcnQsYnVzPXZp
cnRpby1zZXJpYWwwLjAsbnI9MixjaGFyZGV2PWNoYXJjaGFubmVsMSxpZD1jaGFubmVsMSxu
YW1lPWNvbS5yZWRoYXQuc3BpY2UuMCAtZGV2aWNlIHVzYi10YWJsZXQsaWQ9aW5wdXQwLGJ1
cz11c2IuMCxwb3J0PTEgLXNwaWNlIHBvcnQ9NTkwMCxhZGRyPTEyNy4wLjAuMSxkaXNhYmxl
LXRpY2tldGluZyxpbWFnZS1jb21wcmVzc2lvbj1vZmYsc2VhbWxlc3MtbWlncmF0aW9uPW9u
IC1kZXZpY2UgcXhsLXZnYSxpZD12aWRlbzAscmFtX3NpemU9NjcxMDg4NjQsdnJhbV9zaXpl
PTY3MTA4ODY0LHZyYW02NF9zaXplX21iPTAsdmdhbWVtX21iPTE2LG1heF9vdXRwdXRzPTEs
YnVzPXBjaWUuMCxhZGRyPTB4MSAtZGV2aWNlIGljaDktaW50ZWwtaGRhLGlkPXNvdW5kMCxi
dXM9cGNpZS4wLGFkZHI9MHgxYiAtZGV2aWNlIGhkYS1kdXBsZXgsaWQ9c291bmQwLWNvZGVj
MCxidXM9c291bmQwLjAsY2FkPTAgLWNoYXJkZXYgc3BpY2V2bWMsaWQ9Y2hhcnJlZGlyMCxu
YW1lPXVzYnJlZGlyIC1kZXZpY2UgdXNiLXJlZGlyLGNoYXJkZXY9Y2hhcnJlZGlyMCxpZD1y
ZWRpcjAsYnVzPXVzYi4wLHBvcnQ9MiAtY2hhcmRldiBzcGljZXZtYyxpZD1jaGFycmVkaXIx
LG5hbWU9dXNicmVkaXIgLWRldmljZSB1c2ItcmVkaXIsY2hhcmRldj1jaGFycmVkaXIxLGlk
PXJlZGlyMSxidXM9dXNiLjAscG9ydD0zIC1kZXZpY2UgdmlydGlvLWJhbGxvb24tcGNpLGlk
PWJhbGxvb24wLGJ1cz1wY2kuNSxhZGRyPTB4MCAtb2JqZWN0IHJuZy1yYW5kb20saWQ9b2Jq
cm5nMCxmaWxlbmFtZT0vZGV2L3VyYW5kb20gLWRldmljZSB2aXJ0aW8tcm5nLXBjaSxybmc9
b2Jqcm5nMCxpZD1ybmcwLGJ1cz1wY2kuNixhZGRyPTB4MCAtc2FuZGJveCBvbixvYnNvbGV0
ZT1kZW55LGVsZXZhdGVwcml2aWxlZ2VzPWRlbnksc3Bhd249ZGVueSxyZXNvdXJjZWNvbnRy
b2w9ZGVueSAtbXNnIHRpbWVzdGFtcD1vbg0KPiANCj4gc28gZmFyIEkgdGVzdGVkIGp1c3Qg
YnBmLW5leHQvbWFzdGVyOg0KPiAgICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvYnBmL2JwZi1uZXh0LmdpdA0KPiANCg0KSnVzdCB0cmllZCB3aXRo
IHVwc3RyZWFtIExpbnV4ICg1LjE0LjAtcmM2KSBhbmQgeW91ciBjb25maWcgd2l0aG91dCAN
CnRyaWdnZXJpbmcgaXQuIEknbSB1c2luZyAiLWNwdSBob3N0IiwgdGhvdWdoLCBvbiBhbiBB
TUQgUnl6ZW4gOSAzOTAwWA0KDQo+IGFuZCBqc3V0IHJlbW92ZWQgbXkgY2hhbmdlcyB0byBt
YWtlIHN1cmUgaXQgd2Fzbid0IG1lIDstKQ0KDQo6KQ0KDQo+IA0KPiBJJ2xsIHRyeSB0byBm
aW5kIGEgdmVyc2lvbiB0aGF0IHdvcmtlZCBmb3IgbWUgYmVmb3JlDQoNCkNhbiB5b3UgdHJ5
IHdpdGggdXBzdHJlYW0gTGludXggYXMgd2VsbD8NCg0KDQotLSANClRoYW5rcywNCg0KRGF2
aWQgLyBkaGlsZGVuYg0K

