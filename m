Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB28720745
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjFBQSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjFBQSu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:18:50 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8FBC;
        Fri,  2 Jun 2023 09:18:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QXnv969Tpz9xFrS;
        Sat,  3 Jun 2023 00:07:01 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHgPtDFnpkJRAEAw--.3635S2;
        Fri, 02 Jun 2023 17:18:22 +0100 (CET)
Message-ID: <4aa799a0b87d4e2ecf3fa74079402074dc42b3c5.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>,
        hdanton@sina.com, jack@suse.cz, jeffm@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paul@paul-moore.com, peterz@infradead.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Date:   Fri, 02 Jun 2023 18:18:07 +0200
In-Reply-To: <0000000000009d322605fd22054a@google.com>
References: <0000000000009d322605fd22054a@google.com>
Content-Type: multipart/mixed; boundary="=-HLTbvEyGK261gp7cEwEy"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwAHgPtDFnpkJRAEAw--.3635S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw47XF47ArWftr43Ww17Jrb_yoWDJrg_Wr
        W8Ar97CwsrJr1Duan5Awn7twsYq3yxWF10gwn8Jr4SkwsxJF1DGa9I9F4rCrn7Jrs3ZasF
        y3ySv3yvqr4a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C267I2x7xF54xIwI1l5I8C
        rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
        WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC0VAYjxAxZF0Ex2Iq
        xwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UMVCEFc
        xC0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU13CztUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj44KkwAAsz
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-HLTbvEyGK261gp7cEwEy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2023-06-02 at 02:17 -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         4432b507 lsm: fix a number of misspellings
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git next
> console output: https://syzkaller.appspot.com/x/log.txt?x=166c541d280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
> dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1095cd79280000
> 
> Note: testing is done by a robot and is best-effort only.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git next

--=-HLTbvEyGK261gp7cEwEy
Content-Disposition: attachment;
	filename*0=0001-reiserfs-Disable-by-default-security-xattr-init-sinc.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-reiserfs-Disable-by-default-security-xattr-init-sinc.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA3M2JiMDJlYjdhNzUxYzQ0N2FmNDNkN2NhYzdjMTkxMzI5YjZkZDU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5j
b20+CkRhdGU6IEZyaSwgMiBKdW4gMjAyMyAxMDoxMDoyOCArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IHJlaXNlcmZzOiBEaXNhYmxlIGJ5IGRlZmF1bHQgc2VjdXJpdHkgeGF0dHIgaW5pdCBzaW5jZSBp
dAogbmV2ZXIgd29ya2VkCgpDb21taXQgZDgyZGNkOWUyMWI3ICgicmVpc2VyZnM6IEFkZCBzZWN1
cml0eSBwcmVmaXggdG8geGF0dHIgbmFtZSBpbgpyZWlzZXJmc19zZWN1cml0eV93cml0ZSgpIiks
IHdoaWxlIGZpeGVkIHRoZSBzZWN1cml0eSB4YXR0ciBpbml0aWFsaXphdGlvbiwKaXQgYWxzbyBy
ZXZlYWxlZCBhIGNpcmN1bGFyIGxvY2tpbmcgZGVwZW5kZW5jeSBiZXR3ZWVuIHRoZSByZWlzZXJm
cyB3cml0ZQpsb2NrIGFuZCB0aGUgaW5vZGUgbG9jay4KCkFkZCB0aGUgbmV3IGNvbmZpZyBvcHRp
b24gQ09ORklHX1JFSVNFUkZTX0ZTX1NFQ1VSSVRZX0lOSVQgdG8KZW5hYmxlL2Rpc2FibGUgdGhl
IGZlYXR1cmUuIEFsc28sIHNpbmNlIHRoZSBidWcgaW4gc2VjdXJpdHkgeGF0dHIKaW5pdGlhbGl6
YXRpb24gd2FzIGludHJvZHVjZWQgc2luY2UgdGhlIGJlZ2lubmluZywgZGlzYWJsZSBpdCBieSBk
ZWZhdWx0LgoKUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogc3l6Ym90KzhmYjY0YTYxZmRkOTZiNTBm
M2I4QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2VzOiBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS9idWc/ZXh0aWQ9OGZiNjRhNjFmZGQ5NmI1MGYzYjgKU3VnZ2VzdGVkLWJ5OiBK
ZWZmIE1haG9uZXkgPGplZmZtQHN1c2UuY29tPgpTaWduZWQtb2ZmLWJ5OiBSb2JlcnRvIFNhc3N1
IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ci0tLQogZnMvcmVpc2VyZnMvS2NvbmZpZyAgICAg
ICAgICB8IDE1ICsrKysrKysrKysrKysrKwogZnMvcmVpc2VyZnMvc3VwZXIuYyAgICAgICAgICB8
ICAzICsrKwogZnMvcmVpc2VyZnMveGF0dHJfc2VjdXJpdHkuYyB8ICAzICsrKwogMyBmaWxlcyBj
aGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvcmVpc2VyZnMvS2NvbmZp
ZyBiL2ZzL3JlaXNlcmZzL0tjb25maWcKaW5kZXggNGQyMmVjZmUwZmEuLmE2MThkMGJkYTdiIDEw
MDY0NAotLS0gYS9mcy9yZWlzZXJmcy9LY29uZmlnCisrKyBiL2ZzL3JlaXNlcmZzL0tjb25maWcK
QEAgLTg4LDMgKzg4LDE4IEBAIGNvbmZpZyBSRUlTRVJGU19GU19TRUNVUklUWQogCiAJICBJZiB5
b3UgYXJlIG5vdCB1c2luZyBhIHNlY3VyaXR5IG1vZHVsZSB0aGF0IHJlcXVpcmVzIHVzaW5nCiAJ
ICBleHRlbmRlZCBhdHRyaWJ1dGVzIGZvciBmaWxlIHNlY3VyaXR5IGxhYmVscywgc2F5IE4uCisK
K2NvbmZpZyBSRUlTRVJGU19GU19TRUNVUklUWV9JTklUCisJYm9vbCAiUmVpc2VyRlMgU2VjdXJp
dHkgTGFiZWxzIGluaXRpYWxpemF0aW9uIgorCWRlcGVuZHMgb24gUkVJU0VSRlNfRlNfWEFUVFIK
KwlkZWZhdWx0IGZhbHNlCisJaGVscAorCSAgSW5pdCBuZXcgaW5vZGVzIHdpdGggc2VjdXJpdHkg
bGFiZWxzIHByb3ZpZGVkIGJ5IExTTXMuCisKKwkgIEl0IHdhcyBicm9rZW4gZnJvbSB0aGUgYmVn
aW5uaW5nLCBzaW5jZSB0aGUgeGF0dHIgbmFtZSB3YXMKKwkgIG1pc3NpbmcgdGhlICdzZWN1cml0
eS4nIHByZWZpeC4KKworCSAgRW5hYmxpbmcgdGhpcyBvcHRpb24gbWlnaHQgY2F1c2UgbG9ja2Rl
cCB3YXJuaW5ncyBhbmQKKwkgIHVsdGltYXRlbHkgZGVhZGxvY2tzLgorCisJICBJZiB1bnN1cmUs
IHNheSBOLgpkaWZmIC0tZ2l0IGEvZnMvcmVpc2VyZnMvc3VwZXIuYyBiL2ZzL3JlaXNlcmZzL3N1
cGVyLmMKaW5kZXggOTI5YWNjZTZlNzMuLmI0MjdkMDNkMGVhIDEwMDY0NAotLS0gYS9mcy9yZWlz
ZXJmcy9zdXBlci5jCisrKyBiL2ZzL3JlaXNlcmZzL3N1cGVyLmMKQEAgLTE2NTQsNiArMTY1NCw5
IEBAIHN0YXRpYyBpbnQgcmVhZF9zdXBlcl9ibG9jayhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnMsIGlu
dCBvZmZzZXQpCiAKIAlyZWlzZXJmc193YXJuaW5nKE5VTEwsICIiLCAicmVpc2VyZnMgZmlsZXN5
c3RlbSBpcyBkZXByZWNhdGVkIGFuZCAiCiAJCSJzY2hlZHVsZWQgdG8gYmUgcmVtb3ZlZCBmcm9t
IHRoZSBrZXJuZWwgaW4gMjAyNSIpOworCWlmIChJU19FTkFCTEVEKENPTkZJR19SRUlTRVJGU19G
U19TRUNVUklUWV9JTklUKSkKKwkJcmVpc2VyZnNfd2FybmluZyhOVUxMLCAiIiwgImluaXRpYWxp
emluZyBzZWN1cml0eSB4YXR0cnMgY2FuIGNhdXNlIGRlYWRsb2NrcyIpOworCiAJU0JfQlVGRkVS
X1dJVEhfU0IocykgPSBiaDsKIAlTQl9ESVNLX1NVUEVSX0JMT0NLKHMpID0gcnM7CiAKZGlmZiAt
LWdpdCBhL2ZzL3JlaXNlcmZzL3hhdHRyX3NlY3VyaXR5LmMgYi9mcy9yZWlzZXJmcy94YXR0cl9z
ZWN1cml0eS5jCmluZGV4IDA3OGRkOGNjMzEyLi5kODJjNDUwNzgwMyAxMDA2NDQKLS0tIGEvZnMv
cmVpc2VyZnMveGF0dHJfc2VjdXJpdHkuYworKysgYi9mcy9yZWlzZXJmcy94YXR0cl9zZWN1cml0
eS5jCkBAIC02OSw2ICs2OSw5IEBAIGludCByZWlzZXJmc19zZWN1cml0eV9pbml0KHN0cnVjdCBp
bm9kZSAqZGlyLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCXNlYy0+dmFsdWUgPSBOVUxMOwogCXNl
Yy0+bGVuZ3RoID0gMDsKIAorCWlmICghSVNfRU5BQkxFRChDT05GSUdfUkVJU0VSRlNfRlNfU0VD
VVJJVFlfSU5JVCkpCisJCXJldHVybiAwOworCiAJLyogRG9uJ3QgYWRkIHNlbGludXggYXR0cmli
dXRlcyBvbiB4YXR0cnMgLSB0aGV5J2xsIG5ldmVyIGdldCB1c2VkICovCiAJaWYgKElTX1BSSVZB
VEUoZGlyKSkKIAkJcmV0dXJuIDA7Ci0tIAoyLjI1LjEKCg==


--=-HLTbvEyGK261gp7cEwEy--

