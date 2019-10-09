Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1FD186A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfJITLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:18 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44083 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfJITLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MofLl-1hleRf0kjR-00p7Pi; Wed, 09 Oct 2019 21:11:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v6 21/43] compat_ioctl: remove translation for sound ioctls
Date:   Wed,  9 Oct 2019 21:10:21 +0200
Message-Id: <20191009191044.308087-21-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IjOtPhS8f/wctkUCtdYhjt7Oobw/bwEov9yhKM7+na17h4VN3JY
 gHmnOdMMLWjyuU7D6VPosBnNWLPq7nXGG9bXUk6Plla5DGQF81+XJiO7L1ul+HwDru5U88L
 RpKV3fkf4cUUJHNguxV5eXXp6erDfNMmWkk+m7+SzyqMpbmkp2uAaDMuWdneItXf54mg9vC
 sof4kXQMLKDcRwTG1z5yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:izuHaP1RMuY=:rY1acgga02r/4hQ03pOWbC
 vuMdpAdZ0fiJimHzsRIX18ujsrTb1Ns+o6Rp1tWpNI0pZUmyuiQKt/iCA29DW7GqVPzlBk8Qx
 KVTLCBz5tXWw5zPHuxpMCIkSA/7T0tIVlV7zp7auLxYJsEYxwnJ7KlvfoCx33oE9vw4trvJza
 MRMqphsYGu/rshDNHJN6f+prC4kahnhputnjp3fM5wp1xYwte6iSMfMh9oETZFLYwCDtxwQHw
 Tbtfgdt1nm/F5rssDWIL5XaDPEp+jFj82vHHKDT69pccJrt4JhFsTD7a/bC0rT3ihkknM7EXr
 OR0HGRVe+9COtsaUTTL52ESgwOrxlzt7vmtl29RY/tJ8K1hHiSFTdyPaW5G3JdT6NZXp/mTcu
 kqCqNEF1ln8YNyRAf5sGjm0MQYJzm5w4lZ8Z4Lmim7UJUVGhWIsa/8UztbhSD8zvJGlYAyhV6
 PS5jKOBpZ4vv0d6YtQg0lbwCWg6ZRxPgPW5x4/d0bRAhGviHo+UM5tKQIpNHHdm05ki81RpWT
 WPrmejWjUrJ/KmrM+fXlb872eg3aB45pyJ/Vo7AGfzyetrPErYLBLvgllS1mbf2oK306FHoOz
 czzbF9s480+PZAVrug2cpBAy89/NojNGzXlI+c/GiaRXdzGOJw3y/fAQ00LrGzp2EKSjhtvSn
 Kup0suciTeg3whBm4YFcZvCh9kvLOla960H/u1oPrvrcrIt2MoOQE5H0AQ5Jyquf9b3pk7c9N
 wDm1f8YhADCZgc3le6YFTLuxG0T2SCe+OHDKRaMohB2g8v1CLChoHm+pkUtECczjdUaJg8GCF
 WffxTV5EbZarbrNdwzcuYbq7iWxuuQKpJLoR0V3/NcKKHkn8f8HQQdxsjWeVgTNwB8+OZsAra
 iMFR5b0QPzntxUhUhQuQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The SNDCTL_* and SOUND_* commands are the old OSS user interface.

I checked all the sound ioctl commands listed in fs/compat_ioctl.c
to see if we still need the translation handlers. Here is what I
found:

- sound/oss/ is (almost) gone from the kernel, this is what actually
  needed all the translations
- The ALSA emulation for OSS correctly handles all compat_ioctl
  commands already.
- sound/oss/dmasound/ is the last holdout of the original OSS code,
  this is only used on arch/m68k, which has no 64-bit mode and
  hence needs no compat handlers
- arch/um/drivers/hostaudio_kern.c may run in 64-bit mode with
  32-bit x86 user space underneath it. This rare corner case is
  the only one that still needs the compat handlers.

By adding a simple redirect of .compat_ioctl to .unlocked_ioctl in the
UML driver, we can remove all the COMPATIBLE_IOCTL() annotations without
a change in functionality. For completeness, I'm adding the same thing
to the dmasound file, knowing that it makes no difference.

The compat_ioctl list contains one comment about SNDCTL_DSP_MAPINBUF and
SNDCTL_DSP_MAPOUTBUF, which actually would need a translation handler
if implemented. However, the native implementation just returns -EINVAL,
so we don't care.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/hostaudio_kern.c   |   1 +
 fs/compat_ioctl.c                  | 158 -----------------------------
 sound/core/oss/pcm_oss.c           |   4 +
 sound/oss/dmasound/dmasound_core.c |   2 +
 4 files changed, 7 insertions(+), 158 deletions(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index bf75b1ceac47..d35d3f305a31 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -298,6 +298,7 @@ static const struct file_operations hostaudio_fops = {
 	.write          = hostaudio_write,
 	.poll           = hostaudio_poll,
 	.unlocked_ioctl	= hostaudio_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.mmap           = NULL,
 	.open           = hostaudio_open,
 	.release        = hostaudio_release,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 03da7934a351..33f732979f45 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -51,8 +51,6 @@
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 
-#include <linux/soundcard.h>
-
 #include <linux/hiddev.h>
 
 
@@ -458,162 +456,6 @@ COMPATIBLE_IOCTL(PPPIOCDISCONN)
 COMPATIBLE_IOCTL(PPPIOCATTCHAN)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
 COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
-/* Big A */
-/* sparc only */
-/* Big Q for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_SEQ_RESET)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_SYNC)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_INFO)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_CTRLRATE)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_GETOUTCOUNT)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_GETINCOUNT)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_PERCMODE)
-COMPATIBLE_IOCTL(SNDCTL_FM_LOAD_INSTR)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_TESTMIDI)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_RESETSAMPLES)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_NRSYNTHS)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_NRMIDIS)
-COMPATIBLE_IOCTL(SNDCTL_MIDI_INFO)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_THRESHOLD)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_MEMAVL)
-COMPATIBLE_IOCTL(SNDCTL_FM_4OP_ENABLE)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_PANIC)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_OUTOFBAND)
-COMPATIBLE_IOCTL(SNDCTL_SEQ_GETTIME)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_ID)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_CONTROL)
-COMPATIBLE_IOCTL(SNDCTL_SYNTH_REMOVESAMPLE)
-/* Big T for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_TMR_TIMEBASE)
-COMPATIBLE_IOCTL(SNDCTL_TMR_START)
-COMPATIBLE_IOCTL(SNDCTL_TMR_STOP)
-COMPATIBLE_IOCTL(SNDCTL_TMR_CONTINUE)
-COMPATIBLE_IOCTL(SNDCTL_TMR_TEMPO)
-COMPATIBLE_IOCTL(SNDCTL_TMR_SOURCE)
-COMPATIBLE_IOCTL(SNDCTL_TMR_METRONOME)
-COMPATIBLE_IOCTL(SNDCTL_TMR_SELECT)
-/* Little m for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_MIDI_PRETIME)
-COMPATIBLE_IOCTL(SNDCTL_MIDI_MPUMODE)
-COMPATIBLE_IOCTL(SNDCTL_MIDI_MPUCMD)
-/* Big P for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_DSP_RESET)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SYNC)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SPEED)
-COMPATIBLE_IOCTL(SNDCTL_DSP_STEREO)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETBLKSIZE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_CHANNELS)
-COMPATIBLE_IOCTL(SOUND_PCM_WRITE_FILTER)
-COMPATIBLE_IOCTL(SNDCTL_DSP_POST)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SUBDIVIDE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETFRAGMENT)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETFMTS)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETFMT)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETOSPACE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETISPACE)
-COMPATIBLE_IOCTL(SNDCTL_DSP_NONBLOCK)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETCAPS)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETTRIGGER)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETTRIGGER)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETIPTR)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETOPTR)
-/* SNDCTL_DSP_MAPINBUF,  XXX needs translation */
-/* SNDCTL_DSP_MAPOUTBUF,  XXX needs translation */
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETSYNCRO)
-COMPATIBLE_IOCTL(SNDCTL_DSP_SETDUPLEX)
-COMPATIBLE_IOCTL(SNDCTL_DSP_GETODELAY)
-COMPATIBLE_IOCTL(SNDCTL_DSP_PROFILE)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_RATE)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_CHANNELS)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_BITS)
-COMPATIBLE_IOCTL(SOUND_PCM_READ_FILTER)
-/* Big C for sound/OSS */
-COMPATIBLE_IOCTL(SNDCTL_COPR_RESET)
-COMPATIBLE_IOCTL(SNDCTL_COPR_LOAD)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RDATA)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RCODE)
-COMPATIBLE_IOCTL(SNDCTL_COPR_WDATA)
-COMPATIBLE_IOCTL(SNDCTL_COPR_WCODE)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RUN)
-COMPATIBLE_IOCTL(SNDCTL_COPR_HALT)
-COMPATIBLE_IOCTL(SNDCTL_COPR_SENDMSG)
-COMPATIBLE_IOCTL(SNDCTL_COPR_RCVMSG)
-/* Big M for sound/OSS */
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_VOLUME)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_BASS)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_TREBLE)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_SYNTH)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_PCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_SPEAKER)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_MIC)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_CD)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_IMIX)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_ALTPCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_RECLEV)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_IGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_OGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE1)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE2)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_LINE3)
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_DIGITAL1))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_DIGITAL2))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_DIGITAL3))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_PHONEIN))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_PHONEOUT))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_VIDEO))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_RADIO))
-COMPATIBLE_IOCTL(MIXER_READ(SOUND_MIXER_MONITOR))
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_MUTE)
-/* SOUND_MIXER_READ_ENHANCE,  same value as READ_MUTE */
-/* SOUND_MIXER_READ_LOUD,  same value as READ_MUTE */
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_RECSRC)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_DEVMASK)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_RECMASK)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_STEREODEVS)
-COMPATIBLE_IOCTL(SOUND_MIXER_READ_CAPS)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_VOLUME)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_BASS)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_TREBLE)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_SYNTH)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_PCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_SPEAKER)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_MIC)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_CD)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_IMIX)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_ALTPCM)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_RECLEV)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_IGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_OGAIN)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE1)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE2)
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_LINE3)
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_DIGITAL1))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_DIGITAL2))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_DIGITAL3))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_PHONEIN))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_PHONEOUT))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_VIDEO))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_RADIO))
-COMPATIBLE_IOCTL(MIXER_WRITE(SOUND_MIXER_MONITOR))
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_MUTE)
-/* SOUND_MIXER_WRITE_ENHANCE,  same value as WRITE_MUTE */
-/* SOUND_MIXER_WRITE_LOUD,  same value as WRITE_MUTE */
-COMPATIBLE_IOCTL(SOUND_MIXER_WRITE_RECSRC)
-COMPATIBLE_IOCTL(SOUND_MIXER_INFO)
-COMPATIBLE_IOCTL(SOUND_OLD_MIXER_INFO)
-COMPATIBLE_IOCTL(SOUND_MIXER_ACCESS)
-COMPATIBLE_IOCTL(SOUND_MIXER_AGC)
-COMPATIBLE_IOCTL(SOUND_MIXER_3DSE)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE1)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE2)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE3)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE4)
-COMPATIBLE_IOCTL(SOUND_MIXER_PRIVATE5)
-COMPATIBLE_IOCTL(SOUND_MIXER_GETLEVELS)
-COMPATIBLE_IOCTL(SOUND_MIXER_SETLEVELS)
-COMPATIBLE_IOCTL(OSS_GETVERSION)
 /* Raw devices */
 COMPATIBLE_IOCTL(RAW_SETBIND)
 COMPATIBLE_IOCTL(RAW_GETBIND)
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index f57c610d7523..13db77771f0f 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2717,6 +2717,10 @@ static long snd_pcm_oss_ioctl(struct file *file, unsigned int cmd, unsigned long
 static long snd_pcm_oss_ioctl_compat(struct file *file, unsigned int cmd,
 				     unsigned long arg)
 {
+	/*
+	 * Everything is compatbile except SNDCTL_DSP_MAPINBUF/SNDCTL_DSP_MAPOUTBUF,
+	 * which are not implemented for the native case either
+	 */
 	return snd_pcm_oss_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
 #else
diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index fc9bcd47d6a4..f802ea331e24 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -384,6 +384,7 @@ static const struct file_operations mixer_fops =
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.unlocked_ioctl	= mixer_unlocked_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mixer_open,
 	.release	= mixer_release,
 };
@@ -1167,6 +1168,7 @@ static const struct file_operations sq_fops =
 	.write		= sq_write,
 	.poll		= sq_poll,
 	.unlocked_ioctl	= sq_unlocked_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sq_open,
 	.release	= sq_release,
 };
-- 
2.20.0

