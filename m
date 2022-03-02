Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74364CAAF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 18:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiCBRAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 12:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiCBRAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:00:47 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572190CE1;
        Wed,  2 Mar 2022 09:00:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id t11so2602113ioi.7;
        Wed, 02 Mar 2022 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNjcipdV9YowT1QO5QMWP0JgYaGZ3Z13BMTAL5fgvAw=;
        b=Xtjf5OLITutKOukVGPA84IsHJWBk4yqp7GtRwBWK4avdj/o7n7+dEWuLj5+LIDilg4
         V5QnL+HVVqXgxa363Yjm7ls9fOu6BQ8oVxX5dFmcHEJnbTlRrJ4TqQJpsPtQoz+jyMy2
         pnzhPoZTzJpFUq3m3tjBwK6J2ebIcHmL4PY+/UIIhja3w4pi62a3fywuHUgkFHZPQWGD
         S0wjbFthsIYSiNxgA7VEeHgT6+ZUQ447vD4JA518e3I0Z8eTHVB/zehS9hlmB2PisMEZ
         Vir3ofzbZjkmDyMpE6HlFd8R9Q/VkBMH4erW8Rh7DdvwZHLrMc1V6j5+LxzB5ZZVjw+V
         UfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNjcipdV9YowT1QO5QMWP0JgYaGZ3Z13BMTAL5fgvAw=;
        b=mDeYO+ytCCMnfP5wPtUUojZXRpH/86iQUV3NeGPEe5sGmi6OAMxtHzaJvZ5BM8/kVf
         xcvPIusig1Dfu8nSYL+wJW1E+vz7zd7aOgQ+cdQCLbrwEO5u2kstKZtvqymXwfoXHoDc
         +WZvbPk6PpZ72S7OFEsSp8N0nxxTDPS5SpcXKegORS/LjnCzNPLdwL0L2dmMapCB3jle
         9NdyFla4WeipmNabUmP6r8y8auBAqi1ZvbACOZ7C/xvP7RarOfKEIehzTAJZdVEdLyCf
         gzwFRicZfSbn2oHxZzFZQ42OoZLN++WzsIbzWgZrLb5ixGqQeL5WwJGtdb7VH1zWnWWN
         OPsA==
X-Gm-Message-State: AOAM5336kCqJ3fOPK7so+oWmF+wYbxVfLGrGwT1/Ka/oUEhuRHQb7W4p
        YCBu+fwFc3zExjRjp3QDY2cUroFMlYrOGqjcE7dPta4W
X-Google-Smtp-Source: ABdhPJwMwQ7B4JfzldvMXdmu86K4DqhvpTY8uMXZq2AapFxY4XTPMcIXv08ppV3jeqfM/7o9kfYVqR8fyj1xyWcy2Mg=
X-Received: by 2002:a02:ccac:0:b0:314:2074:fec4 with SMTP id
 t12-20020a02ccac000000b003142074fec4mr26294851jap.41.1646240402961; Wed, 02
 Mar 2022 09:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20220301184221.371853-1-amir73il@gmail.com> <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com> <20220302082658.GF3927073@dread.disaster.area>
In-Reply-To: <20220302082658.GF3927073@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Mar 2022 18:59:51 +0200
Message-ID: <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Generic per-sb io stats
To:     Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000006f20d005d93f364d"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000006f20d005d93f364d
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 2, 2022 at 10:27 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Mar 02, 2022 at 09:43:50AM +0200, Amir Goldstein wrote:
> > On Wed, Mar 2, 2022 at 8:59 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, Mar 01, 2022 at 08:42:15PM +0200, Amir Goldstein wrote:
> > > > Miklos,
> > > >
> > > > Following your feedback on v2 [1], I moved the iostats to per-sb.
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://lore.kernel.org/linux-unionfs/20220228113910.1727819-1-amir73il@gmail.com/
> > > >
> > > > Changes since v2:
> > > > - Change from per-mount to per-sb io stats (szeredi)
> > > > - Avoid percpu loop when reading mountstats (dchinner)
> > > >
> > > > Changes since v1:
> > > > - Opt-in for per-mount io stats for overlayfs and fuse
> > >
> > > Why make it optional only for specific filesystem types? Shouldn't
> > > every superblock capture these stats and export them in exactly the
> > > same place?
> > >
> >
> > I am not sure what you are asking.
> >
> > Any filesystem can opt-in to get those generic io stats.
>
> Yes, but why even make it opt-in? Why not just set these up
> unconditionally in alloc_super() for all filesystems? Either this is
> useful information for userspace montioring and diagnostics, or it's
> not useful at all. If it is useful, then all superblocks should
> export this stuff rather than just some special subset of
> filesystems where individual maintainers have noticed it and thought
> "that might be useful".
>
> Just enable it for every superblock....
>

Not that simple.
First of all alloc_super() is used for all sorts of internal kernel sb
(e.g. pipes) that really don't need those stats.

Second, counters can have performance impact.
Depending on the fs, overhead may or may not be significant.
I used the attached patch for testing and ran some micro benchmarks
on tmpfs (10M small read/writes).
The patch hacks -omand for enabling iostats [*]

The results were not great. up to 20% slower when io size > default
batch size (32).
Increasing the counter batch size for rchar/wchar to 1K fixed this
micro benchmark,
but it may not be a one size fits all situation.
So I'd rather be cautious and not enable the feature unconditionally.

Miklos,

In the patches to enable per-sb iostats for fuse and overlayfs I argued why
I think that iostats are more important for fuse/overlayfs than for
other local fs.

Do you agree with my arguments for either fuse/overlayfs or both?
If so, would you rather that per-sb iostats be enabled unconditionally for
fuse/overlayfs or via an opt-in mount option?

Thanks,
Amir.

[*] I tried to figure out how fsconfig() could be used to implement a new
generic sb property (i.e. SB_IOSTATS), but I failed to understand if and how
the new mount API design is intended to address new generic properties, so
I resorted to the SB_MANDLOCK hack.

--0000000000006f20d005d93f364d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v3-0004-fs-enable-per-sb-I-O-stats-for-any-filesystem.patch"
Content-Disposition: attachment; 
	filename="v3-0004-fs-enable-per-sb-I-O-stats-for-any-filesystem.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l09rvyvi0>
X-Attachment-Id: f_l09rvyvi0

RnJvbSA2NjlkODk5YTllNDBjMmM1MTlhODUwYTY1ZTUwMDFmMmIwM2IwNWE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDIgTWFyIDIwMjIgMTE6MDM6MjkgKzAyMDAKU3ViamVjdDogW1BBVENIIHYzIDcv
Nl0gZnM6IGVuYWJsZSBwZXItc2IgSS9PIHN0YXRzIGZvciBhbnkgZmlsZXN5c3RlbQoKT3ZlcnJp
ZGUgU0JfTUFORExPQ0sgZm9yIHRlc3RpbmcuCgpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVp
biA8YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZzL2Z1c2UvaW5vZGUuYyAgICAgICAgICAgIHwg
IDggKysrKy0tLS0KIGZzL25hbWVzcGFjZS5jICAgICAgICAgICAgIHwgIDIgKysKIGZzL292ZXJs
YXlmcy9zdXBlci5jICAgICAgIHwgIDQgLS0tLQogZnMvc3VwZXIuYyAgICAgICAgICAgICAgICAg
fCAgMyArKysKIGluY2x1ZGUvbGludXgvZnNfaW9zdGF0cy5oIHwgMzAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9pbm9kZS5jIGIvZnMvZnVzZS9pbm9kZS5j
CmluZGV4IGYxOWM2NjZiOWFjMy4uNGYwMzE2NzA5ZGYwIDEwMDY0NAotLS0gYS9mcy9mdXNlL2lu
b2RlLmMKKysrIGIvZnMvZnVzZS9pbm9kZS5jCkBAIC0xNDUsOCArMTQ1LDEwIEBAIHN0YXRpYyBp
bnQgZnVzZV9yZWNvbmZpZ3VyZShzdHJ1Y3QgZnNfY29udGV4dCAqZnNjKQogCXN0cnVjdCBzdXBl
cl9ibG9jayAqc2IgPSBmc2MtPnJvb3QtPmRfc2I7CiAKIAlzeW5jX2ZpbGVzeXN0ZW0oc2IpOwor
I2lmbmRlZiBDT05GSUdfRlNfSU9TVEFUUwogCWlmIChmc2MtPnNiX2ZsYWdzICYgU0JfTUFORExP
Q0spCiAJCXJldHVybiAtRUlOVkFMOworI2VuZGlmCiAKIAlyZXR1cm4gMDsKIH0KQEAgLTE1MTQs
MTMgKzE1MTYsMTEgQEAgaW50IGZ1c2VfZmlsbF9zdXBlcl9jb21tb24oc3RydWN0IHN1cGVyX2Js
b2NrICpzYiwgc3RydWN0IGZ1c2VfZnNfY29udGV4dCAqY3R4KQogCXN0cnVjdCBkZW50cnkgKnJv
b3RfZGVudHJ5OwogCWludCBlcnI7CiAKKyNpZm5kZWYgQ09ORklHX0ZTX0lPU1RBVFMKIAllcnIg
PSAtRUlOVkFMOwogCWlmIChzYi0+c19mbGFncyAmIFNCX01BTkRMT0NLKQogCQlnb3RvIGVycjsK
LQotCWVyciA9IHNiX2lvc3RhdHNfaW5pdChzYik7Ci0JaWYgKGVyciAmJiBlcnIgIT0gLUVPUE5P
VFNVUFApCi0JCWdvdG8gZXJyOworI2VuZGlmCiAKIAlyY3VfYXNzaWduX3BvaW50ZXIoZmMtPmN1
cnJfYnVja2V0LCBmdXNlX3N5bmNfYnVja2V0X2FsbG9jKCkpOwogCWZ1c2Vfc2JfZGVmYXVsdHMo
c2IpOwpkaWZmIC0tZ2l0IGEvZnMvbmFtZXNwYWNlLmMgYi9mcy9uYW1lc3BhY2UuYwppbmRleCBk
ZTZmYWU4NGYxYTEuLmViNGViYjUwODFkOSAxMDA2NDQKLS0tIGEvZnMvbmFtZXNwYWNlLmMKKysr
IGIvZnMvbmFtZXNwYWNlLmMKQEAgLTMyOTgsOCArMzI5OCwxMCBAQCBpbnQgcGF0aF9tb3VudChj
b25zdCBjaGFyICpkZXZfbmFtZSwgc3RydWN0IHBhdGggKnBhdGgsCiAJCXJldHVybiByZXQ7CiAJ
aWYgKCFtYXlfbW91bnQoKSkKIAkJcmV0dXJuIC1FUEVSTTsKKyNpZm5kZWYgQ09ORklHX0ZTX0lP
U1RBVFMKIAlpZiAoZmxhZ3MgJiBTQl9NQU5ETE9DSykKIAkJd2Fybl9tYW5kbG9jaygpOworI2Vu
ZGlmCiAKIAkvKiBEZWZhdWx0IHRvIHJlbGF0aW1lIHVubGVzcyBvdmVycmlkZW4gKi8KIAlpZiAo
IShmbGFncyAmIE1TX05PQVRJTUUpKQpkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL3N1cGVyLmMg
Yi9mcy9vdmVybGF5ZnMvc3VwZXIuYwppbmRleCA5NGFiNmFkZWJlMDcuLmQyZjU2OTI2MGVkYyAx
MDA2NDQKLS0tIGEvZnMvb3ZlcmxheWZzL3N1cGVyLmMKKysrIGIvZnMvb3ZlcmxheWZzL3N1cGVy
LmMKQEAgLTE5ODAsMTAgKzE5ODAsNiBAQCBzdGF0aWMgaW50IG92bF9maWxsX3N1cGVyKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHZvaWQgKmRhdGEsIGludCBzaWxlbnQpCiAKIAlzYi0+c19kX29w
ID0gJm92bF9kZW50cnlfb3BlcmF0aW9uczsKIAotCWVyciA9IHNiX2lvc3RhdHNfaW5pdChzYik7
Ci0JaWYgKGVyciAmJiBlcnIgIT0gLUVPUE5PVFNVUFApCi0JCWdvdG8gb3V0OwotCiAJZXJyID0g
LUVOT01FTTsKIAlvZnMgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qgb3ZsX2ZzKSwgR0ZQX0tFUk5F
TCk7CiAJaWYgKCFvZnMpCmRpZmYgLS1naXQgYS9mcy9zdXBlci5jIGIvZnMvc3VwZXIuYwppbmRl
eCBjNDQ3Y2FkYjQwMmIuLmViYWY2NTBmNzJiZiAxMDA2NDQKLS0tIGEvZnMvc3VwZXIuYworKysg
Yi9mcy9zdXBlci5jCkBAIC0xODAsNiArMTgwLDcgQEAgc3RhdGljIHZvaWQgZGVzdHJveV91bnVz
ZWRfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzKQogCXVwX3dyaXRlKCZzLT5zX3Vtb3VudCk7
CiAJbGlzdF9scnVfZGVzdHJveSgmcy0+c19kZW50cnlfbHJ1KTsKIAlsaXN0X2xydV9kZXN0cm95
KCZzLT5zX2lub2RlX2xydSk7CisJc2JfaW9zdGF0c19kZXN0cm95KHMpOwogCXNlY3VyaXR5X3Ni
X2ZyZWUocyk7CiAJcHV0X3VzZXJfbnMocy0+c191c2VyX25zKTsKIAlrZnJlZShzLT5zX3N1YnR5
cGUpOwpAQCAtMTUyMiw2ICsxNTIzLDggQEAgaW50IHZmc19nZXRfdHJlZShzdHJ1Y3QgZnNfY29u
dGV4dCAqZmMpCiAJc2ItPnNfZmxhZ3MgfD0gU0JfQk9STjsKIAogCWVycm9yID0gc2VjdXJpdHlf
c2Jfc2V0X21udF9vcHRzKHNiLCBmYy0+c2VjdXJpdHksIDAsIE5VTEwpOworCWlmICghZXJyb3Ip
CisJCWVycm9yID0gc2JfaW9zdGF0c19jb25maWd1cmUoc2IpOwogCWlmICh1bmxpa2VseShlcnJv
cikpIHsKIAkJZmNfZHJvcF9sb2NrZWQoZmMpOwogCQlyZXR1cm4gZXJyb3I7CmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2ZzX2lvc3RhdHMuaCBiL2luY2x1ZGUvbGludXgvZnNfaW9zdGF0cy5o
CmluZGV4IDYwZDFlZmJlYTdkOS4uYWY1YjVmZjIwMWFhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L2ZzX2lvc3RhdHMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzX2lvc3RhdHMuaApAQCAtNiw2
ICs2LDEzIEBACiAjaW5jbHVkZSA8bGludXgvcGVyY3B1X2NvdW50ZXIuaD4KICNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+CiAKKy8qCisgKiBPdmVycmlkZSBTQl9NQU5ETE9DSyBmb3IgdGVzdGluZy4K
KyAqCisgKiBUT0RPOiB1c2UgZnNvcGVuKCkvZnNjb25maWcoKSBmbGFnIHBhcmFtZXRlcnM/Cisg
Ki8KKyNkZWZpbmUgU0JfSU9TVEFUUwlTQl9NQU5ETE9DSworCiAvKiBTaW1pbGFyIHRvIHRhc2tf
aW9fYWNjb3VudGluZyBtZW1iZXJzICovCiBlbnVtIHsKIAlTQl9JT1NUQVRTX0NIQVJTX1JELAkv
KiBieXRlcyByZWFkIHZpYSBzeXNjYWxscyAqLwpAQCAtNDcsNiArNTQsMTAgQEAgc3RhdGljIGlu
bGluZSBpbnQgc2JfaW9zdGF0c19pbml0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCiB7CiAJaW50
IGVycjsKIAorCS8qIEFscmVhZHkgaW5pdGlhbGl6ZWQ/ICovCisJaWYgKHNiLT5zX2lvc3RhdHMp
CisJCXJldHVybiAwOworCiAJc2ItPnNfaW9zdGF0cyA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCBz
Yl9pb3N0YXRzKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFzYi0+c19pb3N0YXRzKQogCQlyZXR1cm4g
LUVOT01FTTsKQEAgLTYwLDYgKzcxLDE5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNiX2lvc3RhdHNf
aW5pdChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCX0KIAogCXNiLT5zX2lvc3RhdHMtPnN0YXJ0
X3RpbWUgPSBrdGltZV9nZXRfc2Vjb25kcygpOworCXNiLT5zX2ZsYWdzIHw9IFNCX0lPU1RBVFM7
CisJcmV0dXJuIDA7Cit9CisKKy8qIEVuYWJsZS9kaXNhYmxlIGFjY29yZGluZyB0byBTQl9JT1NU
QVRTIGZsYWcgKi8KK3N0YXRpYyBpbmxpbmUgaW50IHNiX2lvc3RhdHNfY29uZmlndXJlKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IpCit7CisJYm9vbCB3YW50X2lvc3RhdHMgPSAoc2ItPnNfZmxhZ3Mg
JiBTQl9JT1NUQVRTKTsKKworCWlmICh3YW50X2lvc3RhdHMgJiYgIXNiLT5zX2lvc3RhdHMpCisJ
CXJldHVybiBzYl9pb3N0YXRzX2luaXQoc2IpOworCWVsc2UgaWYgKCF3YW50X2lvc3RhdHMgJiYg
c2ItPnNfaW9zdGF0cykKKwkJc2JfaW9zdGF0c19kZXN0cm95KHNiKTsKIAlyZXR1cm4gMDsKIH0K
IApAQCAtMTA5LDYgKzEzMywxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2JfaW9zdGF0c19kZXN0
cm95KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCiB7CiB9CiAKK3N0YXRpYyBpbmxpbmUgaW50IHNi
X2lvc3RhdHNfY29uZmlndXJlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCit7CisJc2ItPnNfZmxh
Z3MgJj0gflNCX0lPU1RBVFM7CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBz
Yl9pb3N0YXRzX2NvdW50ZXJfaW5jKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGludCBpZCkKIHsK
IH0KLS0gCjIuMjUuMQoK
--0000000000006f20d005d93f364d--
