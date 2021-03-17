Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330D333F99D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 20:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhCQT7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 15:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233226AbhCQT6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616011130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySpgGvyPy+abjN0pRAe2FOUozIdy/4aZ98taMwFLRJc=;
        b=GcRWyjmq0fmYShXP2dHxntnkQ37cwbiASljrq+AQbXzh18FYvPdRkpQpOizHfnVf1H8GNx
        OpMDfGBzGIwGjo798LRz5aFQPlZzMNsF39FZfFMTjVMvYhsq6GQW80ErGMLe/i4ULhkps7
        5rCkssRyLCBHgy9s3zf9fAkqQ6qDgc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-lawXoNKPPYO8Ngbhfe47oQ-1; Wed, 17 Mar 2021 15:58:46 -0400
X-MC-Unique: lawXoNKPPYO8Ngbhfe47oQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A2F1007488;
        Wed, 17 Mar 2021 19:58:45 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A6306A90C;
        Wed, 17 Mar 2021 19:58:45 +0000 (UTC)
Subject: Re: fs: avoid softlockups in s_inodes iterators commit
To:     David Mozes <david.mozes@silk.us>,
        Eric Sandeen <sandeen@sandeen.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <AM6PR04MB5639492BE427FDA2E1A9F74BF16B9@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <4c7da46e-283b-c1e3-132a-2d8d5d9b2cea@sandeen.net>
 <AM6PR04MB563935FDA6010EA1383AA08BF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <AM6PR04MB5639629BAB2CD2981BAA3AFDF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <80aafc03-90b2-ed68-54a9-0af1499854ec@redhat.com>
Date:   Wed, 17 Mar 2021 14:58:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB5639629BAB2CD2981BAA3AFDF16A9@AM6PR04MB5639.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8xNy8yMSAxMTo0NSBBTSwgRGF2aWQgTW96ZXMgd3JvdGU6DQo+IFNlbmQgZ2luIHRo
ZSBzdGFjayBvZiB0aGUgZmlyc3QgY2FzZSBvbiBkaWZmZXJlbnQgcnVuIA0KPiANCj4gcGFu
aWMgb24gMjUuMi4yMDIxDQo+IHdoYXRjaGcgb24gc2VydmVyIDQuIHRoZSBwbWMgd2FzIHNl
cnZlciB3XDINCj4gRmViIDIzIDA1OjQ2OjA2IGMtbm9kZTA0IGtlcm5lbDogWzEyNTI1OS45
OTAzMzJdIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzQxIHN0dWNrIGZvciAy
MnMhIFtrdWljX21zZ19kb21haW46MTU3OTBdDQo+IEZlYiAyMyAwNTo0NjowNiBjLW5vZGUw
NCBrZXJuZWw6IFsxMjUyNTkuOTkwMzMzXSBNb2R1bGVzIGxpbmtlZCBpbjogaXNjc2lfc2Nz
dChPRSkgY3JjMzJjX2ludGVsKE8pIHNjc3RfbG9jYWwoT0UpIHNjc3RfdXNlcihPRSkgc2Nz
dChPRSkgZHJiZChPKSBscnVfY2FjaGUoTykgODAyMXEoTykgbXJwKE8pIGdhcnAoTykgbmV0
Y29uc29sZShPKSBuZnNkKE8pIG5mc19hY2woTykgYXV0aF9ycGNnc3MoTykgbG9ja2QoTykg
c3VucnBjKE8pIGdyYWNlKE8pIHh0X01BU1FVRVJBREUoTykgeHRfbmF0KE8pIHh0X3N0YXRl
KE8pIGlwdGFibGVfbmF0KE8pIHh0X2FkZHJ0eXBlKE8pIHh0X2Nvbm50cmFjayhPKSBuZl9u
YXQoTykgbmZfY29ubnRyYWNrKE8pIG5mX2RlZnJhZ19pcHY0KE8pIG5mX2RlZnJhZ19pcHY2
KE8pIGxpYmNyYzMyYyhPKSBicl9uZXRmaWx0ZXIoTykgYnJpZGdlKE8pIHN0cChPKSBsbGMo
Tykgb3ZlcmxheShPKSBiZTJpc2NzaShPKSBpc2NzaV9ib290X3N5c2ZzKE8pIGJueDJpKE8p
IGNuaWMoTykgdWlvKE8pIGN4Z2I0aShPKSBjeGdiNChPKSBjeGdiM2koTykgbGliY3hnYmko
TykgY3hnYjMoTykgbWRpbyhPKSBsaWJjeGdiKE8pIGliX2lzZXIoT0UpIGlzY3NpX3RjcChP
KSBsaWJpc2NzaV90Y3AoTykgbGliaXNjc2koTykgc2NzaV90cmFuc3BvcnRfaXNjc2koTykg
ZG1fbXVsdGlwYXRoKE8pIHJkbWFfdWNtKE9FKSBpYl91Y20oT0UpIHJkbWFfY20oT0UpIGl3
X2NtKE9FKSBpYl9pcG9pYihPRSkgaWJfY20oT0UpIGliX3VtYWQoT0UpIG1seDVfZnBnYV90
b29scyhPRSkgbWx4NV9pYihPRSkgaWJfdXZlcmJzKE9FKSBtbHg1X2NvcmUoT0UpIG1kZXYo
T0UpIG1seGZ3KE9FKSBwdHAoTykgcHBzX2NvcmUoTykgbWx4NF9pYihPRSkgaWJfY29yZShP
RSkgbWx4NF9jb3JlKE9FKSBtbHhfY29tcGF0KE9FKSBmdXNlKE8pIGJpbmZtdF9taXNjKE8p
IHB2cGFuaWMoTykgcGNzcGtyKE8pIHZpcnRpb19ybmcoTykgdmlydGlvX25ldChPKSBuZXRf
ZmFpbG92ZXIoTykgZmFpbG92ZXIoTykgaTJjX3BpaXg0KA0KPiBGZWIgMjMgMDU6NDY6MDYg
Yy1ub2RlMDQga2VybmVsOiBPKSBleHQ0KE9FKQ0KPiBGZWIgMjMgMDU6NDY6MDYgYy1ub2Rl
MDQga2VybmVsOiBbMTI1MjU5Ljk5MDM2OF0gIGpiZDIoT0UpIG1iY2FjaGUoT0UpIHZpcnRp
b19zY3NpKE9FKSB2aXJ0aW9fcGNpKE9FKSB2aXJ0aW9fcmluZyhPRSkgdmlydGlvKE9FKSBb
bGFzdCB1bmxvYWRlZDogc2NzdF9sb2NhbF0NCg0Kb2ssIHlvdSBzdGlsbCBoYXZlbid0IHNh
aWQgd2hhdCB5b3VyICJsaWdodCBjdXN0b20iIGNoYW5nZXMgdG8gdGhpcyBrZXJuZWwgYXJl
LCBhbmQgYWxsIG9mIHlvdXIgbW9kdWxlcyBhcmUgb3V0IG9mIHRyZWUgKE8pIGFuZC9vciB1
bnNpZ25lZCAoRSkgc28gSSB3b3VsZCBzdWdnZXN0IGZpcnN0IHRyeWluZyB0byByZXByb2R1
Y2UgdGhpcyBvbiBzb21ldGhpbmcgYSBsb3QgbGVzcyBtZXNzeSBhbmQgY2xvc2VyIHRvIHVw
c3RyZWFtLg0KDQotRXJpYw0K

