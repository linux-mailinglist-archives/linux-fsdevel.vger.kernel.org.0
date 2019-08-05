Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419BA81EC4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfHEOMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 10:12:46 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33781 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHEOMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:12:46 -0400
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hudj8-00073F-AW; Mon, 05 Aug 2019 15:12:42 +0100
Message-ID: <eb2027cdccc0a0ff0a9d061fa8dd04a927c63819.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Deepa Dinamani <deepa.kernel@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Date:   Mon, 05 Aug 2019 15:12:41 +0100
In-Reply-To: <20190730014924.2193-5-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
         <20190730014924.2193-5-deepa.kernel@gmail.com>
Organization: Codethink Ltd.
Content-Type: multipart/mixed; boundary="=-a+HH+daN/DaPKAYw0nvQ"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-a+HH+daN/DaPKAYw0nvQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> The warning reuses the uptime max of 30 years used by the
> setitimeofday().
> 
> Note that the warning is only added for new filesystem mounts
> through the mount syscall. Automounts do not have the same warning.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  fs/namespace.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index b26778bdc236..5314fac8035e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2739,6 +2739,17 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
>  	if (error < 0)
>  		mntput(mnt);
> +
> +	if (!error && sb->s_time_max &&

I don't know why you are testing sb->s_time_max here - it should always
be non-zero since alloc_super() sets it to TIME64_MAX.

> +	    (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
> +		char *buf = (char *)__get_free_page(GFP_KERNEL);
> +		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
> +
> +		pr_warn("Mounted %s file system at %s supports timestamps until 0x%llx\n",
> +			fc->fs_type->name, mntpath, (unsigned long long)sb->s_time_max);

This doesn't seem like a helpful way to log the time.  Maybe use
time64_to_tm() to convert to "broken down" time and then print it with
"%ptR"... but that wants struct rtc_time.  If you apply the attached
patch, however, you should then be able to print struct tm with
"%ptT".

Ben.

> +		free_page((unsigned long)buf);
> +	}
> +
>  	return error;
>  }
>  
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

--=-a+HH+daN/DaPKAYw0nvQ
Content-Disposition: attachment;
	filename*0=0001-vsprintf-Add-support-for-printing-struct-tm-in-human.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-vsprintf-Add-support-for-printing-struct-tm-in-human.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA0MGNkNTEzNTZkMzY2MTEwZDMzYjg5MWE2YjlmM2E0MjhlZDRhYjJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW4gSHV0Y2hpbmdzIDxiZW4uaHV0Y2hpbmdzQGNvZGV0aGlu
ay5jby51az4KRGF0ZTogTW9uLCA1IEF1ZyAyMDE5IDE0OjQ5OjMzICswMTAwClN1YmplY3Q6IFtQ
QVRDSF0gdnNwcmludGY6IEFkZCBzdXBwb3J0IGZvciBwcmludGluZyBzdHJ1Y3QgdG0gaW4KIGh1
bWFuLXJlYWRhYmxlIGZvcm1hdAoKQ2hhbmdlIGRhdGVfc3RyKCksIHRpbWVfc3RyKCksIHJ0Y19z
dHIoKSB0byB0YWtlIGEgc3RydWN0IHRtICh0aGUgbWFpbgprQVBJIHR5cGUpIGluc3RlYWQgb2Yg
c3RydWN0IHJ0Y190aW1lICh1QVBJIHR5cGUpLCBhbmQgcmVuYW1lIHJ0Y19zdHIoKQphY2NvcmRp
bmdseS4KCkNoYW5nZSB0aW1lX2FuZF9kYXRlKCkgdG8gYWNjZXB0IGVpdGhlciBhIHN0cnVjdCBy
dGNfdGltZSAoJ1InKSBvcgphIHN0cnVjdCB0bSAoJ1QnKSwgY29udmVydGluZyB0aGUgZm9ybWVy
IHRvIHRoZSBsYXR0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBCZW4gSHV0Y2hpbmdzIDxiZW4uaHV0Y2hp
bmdzQGNvZGV0aGluay5jby51az4KLS0tCiBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL3ByaW50ay1m
b3JtYXRzLnJzdCB8ICA2ICsrLS0KIGxpYi92c3ByaW50Zi5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKy0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjcg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5yc3QgYi9Eb2N1bWVudGF0aW9uL2NvcmUtYXBpL3By
aW50ay1mb3JtYXRzLnJzdAppbmRleCA3NWQyYmJlOTgxM2YuLmZiYWUwMjBiY2MyMiAxMDA2NDQK
LS0tIGEvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5yc3QKKysrIGIvRG9j
dW1lbnRhdGlvbi9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5yc3QKQEAgLTQzNiwxMCArNDM2LDEw
IEBAIFRpbWUgYW5kIGRhdGUgKHN0cnVjdCBydGNfdGltZSkKIAklcHRSCQlZWVlZLW1tLWRkVEhI
Ok1NOlNTCiAJJXB0UmQJCVlZWVktbW0tZGQKIAklcHRSdAkJSEg6TU06U1MKLQklcHRSW2R0XVty
XQorCSVwdFtSVF1bZHRdW3JdCiAKLUZvciBwcmludGluZyBkYXRlIGFuZCB0aW1lIGFzIHJlcHJl
c2VudGVkIGJ5IHN0cnVjdCBydGNfdGltZSBzdHJ1Y3R1cmUgaW4KLWh1bWFuIHJlYWRhYmxlIGZv
cm1hdC4KK0ZvciBwcmludGluZyBkYXRlIGFuZCB0aW1lIGFzIHJlcHJlc2VudGVkIGJ5IHN0cnVj
dCBydGNfdGltZSAoUikgb3Igc3RydWN0Cit0bSAoVCkgc3RydWN0dXJlIGluIGh1bWFuIHJlYWRh
YmxlIGZvcm1hdC4KIAogQnkgZGVmYXVsdCB5ZWFyIHdpbGwgYmUgaW5jcmVtZW50ZWQgYnkgMTkw
MCBhbmQgbW9udGggYnkgMS4gVXNlICVwdFJyIChyYXcpCiB0byBzdXBwcmVzcyB0aGlzIGJlaGF2
aW91ci4KZGlmZiAtLWdpdCBhL2xpYi92c3ByaW50Zi5jIGIvbGliL3ZzcHJpbnRmLmMKaW5kZXgg
NjM5MzcwNDRjNTdkLi5kYzMyNzQyODc2ZmQgMTAwNjQ0Ci0tLSBhL2xpYi92c3ByaW50Zi5jCisr
KyBiL2xpYi92c3ByaW50Zi5jCkBAIC0xNjk5LDcgKzE2OTksNyBAQCBjaGFyICphZGRyZXNzX3Zh
bChjaGFyICpidWYsIGNoYXIgKmVuZCwgY29uc3Qgdm9pZCAqYWRkciwKIH0KIAogc3RhdGljIG5v
aW5saW5lX2Zvcl9zdGFjawotY2hhciAqZGF0ZV9zdHIoY2hhciAqYnVmLCBjaGFyICplbmQsIGNv
bnN0IHN0cnVjdCBydGNfdGltZSAqdG0sIGJvb2wgcikKK2NoYXIgKmRhdGVfc3RyKGNoYXIgKmJ1
ZiwgY2hhciAqZW5kLCBjb25zdCBzdHJ1Y3QgdG0gKnRtLCBib29sIHIpCiB7CiAJaW50IHllYXIg
PSB0bS0+dG1feWVhciArIChyID8gMCA6IDE5MDApOwogCWludCBtb24gPSB0bS0+dG1fbW9uICsg
KHIgPyAwIDogMSk7CkBAIC0xNzE4LDcgKzE3MTgsNyBAQCBjaGFyICpkYXRlX3N0cihjaGFyICpi
dWYsIGNoYXIgKmVuZCwgY29uc3Qgc3RydWN0IHJ0Y190aW1lICp0bSwgYm9vbCByKQogfQogCiBz
dGF0aWMgbm9pbmxpbmVfZm9yX3N0YWNrCi1jaGFyICp0aW1lX3N0cihjaGFyICpidWYsIGNoYXIg
KmVuZCwgY29uc3Qgc3RydWN0IHJ0Y190aW1lICp0bSwgYm9vbCByKQorY2hhciAqdGltZV9zdHIo
Y2hhciAqYnVmLCBjaGFyICplbmQsIGNvbnN0IHN0cnVjdCB0bSAqdG0sIGJvb2wgcikKIHsKIAli
dWYgPSBudW1iZXIoYnVmLCBlbmQsIHRtLT50bV9ob3VyLCBkZWZhdWx0X2RlYzAyX3NwZWMpOwog
CWlmIChidWYgPCBlbmQpCkBAIC0xNzM0LDE2ICsxNzM0LDEzIEBAIGNoYXIgKnRpbWVfc3RyKGNo
YXIgKmJ1ZiwgY2hhciAqZW5kLCBjb25zdCBzdHJ1Y3QgcnRjX3RpbWUgKnRtLCBib29sIHIpCiB9
CiAKIHN0YXRpYyBub2lubGluZV9mb3Jfc3RhY2sKLWNoYXIgKnJ0Y19zdHIoY2hhciAqYnVmLCBj
aGFyICplbmQsIGNvbnN0IHN0cnVjdCBydGNfdGltZSAqdG0sCi0JICAgICAgc3RydWN0IHByaW50
Zl9zcGVjIHNwZWMsIGNvbnN0IGNoYXIgKmZtdCkKK2NoYXIgKnN0cnVjdF90bV9zdHIoY2hhciAq
YnVmLCBjaGFyICplbmQsIGNvbnN0IHN0cnVjdCB0bSAqdG0sCisJCSAgICBzdHJ1Y3QgcHJpbnRm
X3NwZWMgc3BlYywgY29uc3QgY2hhciAqZm10KQogewogCWJvb2wgaGF2ZV90ID0gdHJ1ZSwgaGF2
ZV9kID0gdHJ1ZTsKIAlib29sIHJhdyA9IGZhbHNlOwogCWludCBjb3VudCA9IDI7CiAKLQlpZiAo
Y2hlY2tfcG9pbnRlcigmYnVmLCBlbmQsIHRtLCBzcGVjKSkKLQkJcmV0dXJuIGJ1ZjsKLQogCXN3
aXRjaCAoZm10W2NvdW50XSkgewogCWNhc2UgJ2QnOgogCQloYXZlX3QgPSBmYWxzZTsKQEAgLTE3
NzUsMTEgKzE3NzIsMjggQEAgc3RhdGljIG5vaW5saW5lX2Zvcl9zdGFjawogY2hhciAqdGltZV9h
bmRfZGF0ZShjaGFyICpidWYsIGNoYXIgKmVuZCwgdm9pZCAqcHRyLCBzdHJ1Y3QgcHJpbnRmX3Nw
ZWMgc3BlYywKIAkJICAgIGNvbnN0IGNoYXIgKmZtdCkKIHsKKwlpZiAoY2hlY2tfcG9pbnRlcigm
YnVmLCBlbmQsIHB0ciwgc3BlYykpCisJCXJldHVybiBidWY7CisKIAlzd2l0Y2ggKGZtdFsxXSkg
ewotCWNhc2UgJ1InOgotCQlyZXR1cm4gcnRjX3N0cihidWYsIGVuZCwgKGNvbnN0IHN0cnVjdCBy
dGNfdGltZSAqKXB0ciwgc3BlYywgZm10KTsKKwljYXNlICdSJzogeworCQljb25zdCBzdHJ1Y3Qg
cnRjX3RpbWUgKnJ0bSA9IChjb25zdCBzdHJ1Y3QgcnRjX3RpbWUgKilwdHI7CisJCXN0cnVjdCB0
bSB0bSA9IHsKKwkJCS50bV9zZWMgID0gcnRtLT50bV9zZWMsCisJCQkudG1fbWluICA9IHJ0bS0+
dG1fbWluLAorCQkJLnRtX2hvdXIgPSBydG0tPnRtX2hvdXIsCisJCQkudG1fbWRheSA9IHJ0bS0+
dG1fbWRheSwKKwkJCS50bV9tb24gID0gcnRtLT50bV9tb24sCisJCQkudG1feWVhciA9IHJ0bS0+
dG1feWVhciwKKwkJfTsKKworCQlyZXR1cm4gc3RydWN0X3RtX3N0cihidWYsIGVuZCwgJnRtLCBz
cGVjLCBmbXQpOworCX0KKwljYXNlICdUJzoKKwkJcmV0dXJuIHN0cnVjdF90bV9zdHIoYnVmLCBl
bmQsIChjb25zdCBzdHJ1Y3QgdG0gKilwdHIsCisJCQkJICAgICBzcGVjLCBmbXQpOwogCWRlZmF1
bHQ6Ci0JCXJldHVybiBlcnJvcl9zdHJpbmcoYnVmLCBlbmQsICIoJXB0Uj8pIiwgc3BlYyk7CisJ
CXJldHVybiBlcnJvcl9zdHJpbmcoYnVmLCBlbmQsICIoJXB0PykiLCBzcGVjKTsKIAl9CiB9CiAK
LS0gCkJlbiBIdXRjaGluZ3MsIFNvZnR3YXJlIERldmVsb3BlciAgICAgICAgICAgICAgICAgICAg
ICAgICBDb2RldGhpbmsgTHRkCmh0dHBzOi8vd3d3LmNvZGV0aGluay5jby51ay8gICAgICAgICAg
ICAgICAgIERhbGUgSG91c2UsIDM1IERhbGUgU3RyZWV0CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBNYW5jaGVzdGVyLCBNMSAySEYsIFVuaXRlZCBLaW5nZG9tCgo=


--=-a+HH+daN/DaPKAYw0nvQ--

