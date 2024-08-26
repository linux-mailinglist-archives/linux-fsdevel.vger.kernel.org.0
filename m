Return-Path: <linux-fsdevel+bounces-27088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B795E78F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3775B20E56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 04:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302D57CAC;
	Mon, 26 Aug 2024 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isdpZ5aB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F963C;
	Mon, 26 Aug 2024 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645472; cv=none; b=gYn2RUd3YaZ9V5AqAPftzObJ2tnicNfKYLNe3pMHpKrZtSWi1oMBWOfyZBW8TTZWzu+elqbIvOuMoaKmkGyn0UI5GiuSG69XcwsdHvCT9y2775HsOCJo4xXrEeWg/UC5f2TbJKwBUj038zQjqiuhoURdVssg+YCRRnv+ri/aBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645472; c=relaxed/simple;
	bh=xI1ss2UE+lyV3cfgg/1xra561XX53Yez7xzeOX4PzQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kw9mrIphFnh0FfnZAMD92NrzmDkZjLa60yc+T/SURvOMRKSNpxcrWLbxL/jlQhvXf/ma/81QikqSgRpO+Pds7MQzA1oPN3DNPdFyCwQ3gNPzWSrKM4P6oN39DtqQoK52q0eoOFMv58EPsLYkjbQ5MTbBiiAuwVsuKd3A7pp1BwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isdpZ5aB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202376301e6so26806295ad.0;
        Sun, 25 Aug 2024 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724645470; x=1725250270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xI1ss2UE+lyV3cfgg/1xra561XX53Yez7xzeOX4PzQU=;
        b=isdpZ5aBFZzzO2yDQB+SmLkLKrdojD8PEo0hlCj+HErumF3Gz2EdVatX4wtXKlD5te
         9BHSwnnJdCheZHK4EMh0XsWtuIy/aeF4MEsmd0H5qqvw/TMo0Zms5tCL2ScQT5LVR1Uc
         JoRbxFAlqi2XoAeGGUXn7Ly5eK7Ap/fTKNAo31ZxQgBGqNfaOpsMFPgx8dVucIYQcNAS
         FyVlN+pUav0ZjOKdEBlPPyYrs+3TB8e7E1xhvauIA6K3z7cNX0Cmnhd1OZwO8DNNtTpV
         YjLiqa6MfYH/yqcEUnuh53OBuoS8Jtp7ItZux3VtRDXFz4kOSiROJ2FwoW0FYsDjrhO1
         J/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724645470; x=1725250270;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xI1ss2UE+lyV3cfgg/1xra561XX53Yez7xzeOX4PzQU=;
        b=d8ueG/Ci2zrLoQO2sMuI6UPoPKs8/n6t5vnf3L9ZG4vu8jpMOTGBk0XuvDnKMcJQId
         jjTCHSb3IyUpyiCeMwysjrQj+3Lyj0IGaB5soSCkg2On2JjQDkcqkitffRM5s3/2K3wM
         b8wpoO+0jtz0WrItqdN6pYqg7fWgn5rC/IwxZ9DlbAsSpb/Xd/XpmgULJJpyns9FZyMY
         9M9S0JDTF/r2H2AHcUll8/yDSGjWorcsBDBNyX9m0zk4Ra3Ys1pyDMUMuHJdShNQgZas
         CwOu68f1EEpS2c/NELK9cBkCb0sVqHH9JRa4tD+cG1xxcTrU6TCfsfSlbBKDTkzHZ99D
         Mw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVikh8NPH9ElLp9v35XmDKNv1agGD+hxSN8baegGA3duTjaguL/BPWc/WE1DPKEohaZZO9ZePpj@vger.kernel.org, AJvYcCWH1CvKtVzaFFtU0Ahzm40VlqBO0wDXbIxFe9kX77WMG3W1HknMyzKrZ+REmJ34TmZVPH9BdMz+pBSADw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmfry6Y2KxjJLUgv8JnDDh5VgiQirGelVaTn59atVHcanTQ7fg
	s5S76bz6J5NanCAR4Wk/feAVy4CBXlK/l0H9gCq6vIu+ubbn38y5
X-Google-Smtp-Source: AGHT+IGZ8w9gvea6g2wghhbzeQMVA8r0Du9ILNDAH0N61QasyIN/BXMPEmlWs3bDwEgZOJzkBgxEuA==
X-Received: by 2002:a17:903:244a:b0:201:ed48:f11c with SMTP id d9443c01a7336-2039e34f793mr104057465ad.0.1724645469586;
        Sun, 25 Aug 2024 21:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd269sm60388925ad.135.2024.08.25.21.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 21:11:09 -0700 (PDT)
Message-ID: <e8c68d82d7209fc64823bd25eee3175c2a7e8ec4.camel@gmail.com>
Subject: Re: [PATCH] vfs: fix race between evice_inodes() and
 find_inode()&iput()
From: Julian Sun <sunjunchao2870@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 david@fromorbit.com,  zhuyifei1999@gmail.com,
 syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
Date: Mon, 26 Aug 2024 12:11:04 +0800
In-Reply-To: <rvorqwxqlpray26yi3epqpxjiijr77nvle3ts5glvwitebrl6e@vcvqfk2bf6sj>
References: <20240823130730.658881-1-sunjunchao2870@gmail.com>
	 <rvorqwxqlpray26yi3epqpxjiijr77nvle3ts5glvwitebrl6e@vcvqfk2bf6sj>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU2F0LCAyMDI0LTA4LTI0IGF0IDA2OjU0ICswMjAwLCBNYXRldXN6IEd1emlrIHdyb3RlOgo+
IE9uIEZyaSwgQXVnIDIzLCAyMDI0IGF0IDA5OjA3OjMwUE0gKzA4MDAsIEp1bGlhbiBTdW4gd3Jv
dGU6Cj4gPiBIaSwgYWxsCj4gPiAKPiA+IFJlY2VudGx5IEkgbm90aWNlZCBhIGJ1Z1sxXSBpbiBi
dHJmcywgYWZ0ZXIgZGlnZ2VkIGl0IGludG8KPiA+IGFuZCBJIGJlbGlldmUgaXQnYSByYWNlIGlu
IHZmcy4KPiA+IAo+ID4gTGV0J3MgYXNzdW1lIHRoZXJlJ3MgYSBpbm9kZSAoaWUgaW5vIDI2MSkg
d2l0aCBpX2NvdW50IDEgaXMKPiA+IGNhbGxlZCBieSBpcHV0KCksIGFuZCB0aGVyZSdzIGEgY29u
Y3VycmVudCB0aHJlYWQgY2FsbGluZwo+ID4gZ2VuZXJpY19zaHV0ZG93bl9zdXBlcigpLgo+ID4g
Cj4gPiBjcHUwOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3B1MToKPiA+IGlwdXQoKSAvLyBpX2NvdW50IGlzIDEKPiA+IMKgIC0+c3Bp
bl9sb2NrKGlub2RlKQo+ID4gwqAgLT5kZWMgaV9jb3VudCB0byAwCj4gPiDCoCAtPmlwdXRfZmlu
YWwoKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdlbmVyaWNfc2h1dGRv
d25fc3VwZXIoKQo+ID4gwqDCoMKgIC0+X19pbm9kZV9hZGRfbHJ1KCnCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC0+ZXZpY3RfaW5vZGVzKCkKPiA+IMKgwqDCoMKgwqAgLy8gY2F1c2Ugc29t
ZSByZWFzb25bMl3CoMKgwqDCoMKgwqDCoMKgwqDCoCAtPmlmIChhdG9taWNfcmVhZChpbm9kZS0K
PiA+ID5pX2NvdW50KSkgY29udGludWU7Cj4gPiDCoMKgwqDCoMKgIC8vIHJldHVybiBiZWZvcmXC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIGlub2RlIDI2MSBwYXNzZWQgdGhl
Cj4gPiBhYm92ZSBjaGVjawo+ID4gwqDCoMKgwqDCoCAvLyBsaXN0X2xydV9hZGRfb2JqKCnCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLy8gYW5kIHRoZW4gc2NoZWR1bGUgb3V0Cj4gPiDCoMKgIC0+
c3Bpbl91bmxvY2soKQo+ID4gLy8gbm90ZSBoZXJlOiB0aGUgaW5vZGUgMjYxCj4gPiAvLyB3YXMg
c3RpbGwgYXQgc2IgbGlzdCBhbmQgaGFzaCBsaXN0LAo+ID4gLy8gYW5kIElfRlJFRUlOR3xJX1dJ
TExfRlJFRSB3YXMgbm90IGJlZW4gc2V0Cj4gPiAKPiA+IGJ0cmZzX2lnZXQoKQo+ID4gwqAgLy8g
YWZ0ZXIgc29tZSBmdW5jdGlvbiBjYWxscwo+ID4gwqAgLT5maW5kX2lub2RlKCkKPiA+IMKgwqDC
oCAvLyBmb3VuZCB0aGUgYWJvdmUgaW5vZGUgMjYxCj4gPiDCoMKgwqAgLT5zcGluX2xvY2soaW5v
ZGUpCj4gPiDCoMKgIC8vIGNoZWNrIElfRlJFRUlOR3xJX1dJTExfRlJFRQo+ID4gwqDCoCAvLyBh
bmQgcGFzc2VkCj4gPiDCoMKgwqDCoMKgIC0+X19pZ2V0KCkKPiA+IMKgwqDCoCAtPnNwaW5fdW5s
b2NrKGlub2RlKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvLyBzY2hlZHVsZSBiYWNr
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLT5zcGluX2xvY2soaW5vZGUpCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLy8gY2hlY2sKPiA+IChJX05FV3xJX0ZSRUVJTkd8SV9XSUxMX0ZSRUUp
IGZsYWdzLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIHBhc3NlZCBhbmQgc2V0IElfRlJF
RUlORwo+ID4gaXB1dCgpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0+c3Bpbl91bmxvY2soaW5vZGUpCj4gPiDCoCAtPnNw
aW5fbG9jayhpbm9kZSnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LT5ldmljdCgpCj4gPiDCoCAvLyBkZWMgaV9jb3VudCB0byAwCj4gPiDCoCAtPmlwdXRfZmluYWwo
KQo+ID4gwqDCoMKgIC0+c3Bpbl91bmxvY2soKQo+ID4gwqDCoMKgIC0+ZXZpY3QoKQo+ID4gCj4g
PiBOb3csIHdlIGhhdmUgdHdvIHRocmVhZHMgc2ltdWx0YW5lb3VzbHkgZXZpY3RpbmcKPiA+IHRo
ZSBzYW1lIGlub2RlLCB3aGljaCBtYXkgdHJpZ2dlciB0aGUgQlVHKGlub2RlLT5pX3N0YXRlICYg
SV9DTEVBUikKPiA+IHN0YXRlbWVudCBib3RoIHdpdGhpbiBjbGVhcl9pbm9kZSgpIGFuZCBpcHV0
KCkuCj4gPiAKPiA+IFRvIGZpeCB0aGUgYnVnLCByZWNoZWNrIHRoZSBpbm9kZS0+aV9jb3VudCBh
ZnRlciBob2xkaW5nIGlfbG9jay4KPiA+IEJlY2F1c2UgaW4gdGhlIG1vc3Qgc2NlbmFyaW9zLCB0
aGUgZmlyc3QgY2hlY2sgaXMgdmFsaWQsIGFuZAo+ID4gdGhlIG92ZXJoZWFkIG9mIHNwaW5fbG9j
aygpIGNhbiBiZSByZWR1Y2VkLgo+ID4gCj4gPiBJZiB0aGVyZSBpcyBhbnkgbWlzdW5kZXJzdGFu
ZGluZywgcGxlYXNlIGxldCBtZSBrbm93LCB0aGFua3MuCj4gPiAKPiA+IFsxXToKPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzAwMDAwMDAwMDAwMGVhYmUxZDA2MTljNDg5
ODZAZ29vZ2xlLmNvbS8KPiA+IFsyXTogVGhlIHJlYXNvbiBtaWdodCBiZSAxLiBTQl9BQ1RJVkUg
d2FzIHJlbW92ZWQgb3IgMi4KPiA+IG1hcHBpbmdfc2hyaW5rYWJsZSgpCj4gPiByZXR1cm4gZmFs
c2Ugd2hlbiBJIHJlcHJvZHVjZWQgdGhlIGJ1Zy4KPiA+IAo+ID4gUmVwb3J0ZWQtYnk6IHN5emJv
dCs2N2JhM2M0MmJjYmI0NjY1ZDNhZEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiBDbG9z
ZXM6Cj4gPiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9NjdiYTNjNDJi
Y2JiNDY2NWQzYWQKPiA+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4gPiBGaXhlczogNjM5
OTdlOThhM2JlICgic3BsaXQgaW52YWxpZGF0ZV9pbm9kZXMoKSIpCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKdWxpYW4gU3VuIDxzdW5qdW5jaGFvMjg3MEBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+IMKgZnMv
aW5vZGUuYyB8IDQgKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4g
PiAKPiA+IGRpZmYgLS1naXQgYS9mcy9pbm9kZS5jIGIvZnMvaW5vZGUuYwo+ID4gaW5kZXggM2E0
MWY4M2E0YmE1Li4wMTFmNjMwNzc3ZDAgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9pbm9kZS5jCj4gPiAr
KysgYi9mcy9pbm9kZS5jCj4gPiBAQCAtNzIzLDYgKzcyMywxMCBAQCB2b2lkIGV2aWN0X2lub2Rl
cyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2soJmlub2RlLT5pX2xvY2spOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChhdG9taWNfcmVhZCgmaW5vZGUtPmlfY291bnQpKSB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5f
dW5sb2NrKCZpbm9kZS0+aV9sb2NrKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgfQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaW5vZGUtPmlf
c3RhdGUgJiAoSV9ORVcgfCBJX0ZSRUVJTkcgfAo+ID4gSV9XSUxMX0ZSRUUpKSB7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX3VubG9jaygm
aW5vZGUtPmlfbG9jayk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjb250aW51ZTsKPiAKPiBUaGlzIGxvb2tzIGNvcnJlY3QgdG8gbWUsIGFsYmVp
dCBJIHdvdWxkIGFyZ3VlIHRoZSBjb21taXQgbWVzc2FnZSBpcwo+IG92ZXJseSB2ZXJib3NlIG1h
a2luZyBpdCBoYXJkZXIgdG8gdW5kZXJzdGFuZCB0aGUgZ2lzdCBvZiB0aGUKPiBwcm9ibGVtOgo+
IGV2aWN0X2lub2RlcygpIGZhaWxzIHRvIHJlLWNoZWNrIGlfY291bnQgYWZ0ZXIgYWNxdWlyaW5n
IHRoZSBzcGluCj4gbG9jaywKPiB3aGlsZSB0aGUgZmxhZ3MgYmxvY2tpbmcgMC0+MSBpX2NvdW50
IHRyYW5zaXNpb25zIGFyZSBub3Qgc2V0IHlldCwKPiBtYWtpbmcgaXQgcG9zc2libGUgdG8gcmFj
ZSBhZ2FpbnN0IHN1Y2ggdHJhbnNpdGlvbi4KQWxyaWdodCwgSSB0aGluayB0aGUgaXNzdWUgaXMg
Y2xlYXJseSBleHBsYWluZWQgdGhyb3VnaCB0aGUgYWJvdmUKY29tbWl0IG1lc3NhZ2UuIElmIHlv
dSBpbnNpc3QsIEkgY2FuIHNlbmQgYSBwYXRjaCB2MiB0byByZW9yZGVyIHRoZQpjb21taXQgbWVz
c2FnZS4KPiAKPiBUaGUgcmVhbCByZW1hcmsgSSBoYXZlIGhlcmUgaXMgdGhhdCBldmljdF9pbm9k
ZXMoKSwgbW9kdWxvIHRoZSBidWcsCj4gaXMKPiBpZGVudGljYWwgdG8gaW52YWxpZGF0ZV9pbm9k
ZXMoKS4gUGVyaGFwcyBhIHNlcGFyYXRlIHBhdGNoICgqbm90KiBmb3IKPiBzdGFibGUpIHRvIHdo
YWNrIGl0IHdvdWxkIGJlIHBydWRlbnQ/CkFncmVlZC4gV2UgY2FuIHJlcGxhY2UgaW52YWxpZGF0
ZV9pbm9kZXMoKSB3aXRoIGV2aWN0X2lub2RlcygpIGFmdGVyCnRoaXMgcGF0Y2guCgpUaGFua3Ms
Ci0tIApKdWxpYW4gU3VuIDxzdW5qdW5jaGFvMjg3MEBnbWFpbC5jb20+Cg==


